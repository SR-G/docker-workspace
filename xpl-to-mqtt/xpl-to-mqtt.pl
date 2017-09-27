#!/usr/bin/perl -w

print("xpl-to-mqtt starting ...\n");
use strict;
use warnings;
use diagnostics;
use Getopt::Long;
use Pod::Usage;
use xPL::Client;
use AnyEvent::MQTT;
my %args = ( vendor_id => 'bnz', device_id => 'listener', );
my %opt = ();
my $verbose;
my $interface;
my $help;

GetOptions('verbose+' => \$verbose, 'interface=s' => \$interface, 'define=s' => \%opt, 'help|?|h' => \$help, ) or pod2usage(2);
$args{'interface'} = $interface if ($interface);
$args{'verbose'} = $verbose if ($verbose);

# Create an xPL Client object
my $mqtt = AnyEvent::MQTT->new("host" => $ENV{'MQTT_HOSTNAME'}, "port" => $ENV{'MQTT_PORT'}); # keep-alive can be customized as an additional parameter, see documentation
my $xpl = xPL::Client->new(%args, %opt) or die "Failed to create xPL::Client\n";

# Add a callback to receive all incoming xPL messages
$xpl->add_xpl_callback(id => "logger", self_skip => 0, targetted => 0, callback => \&log, filter => "@ARGV");

# Run the main loop
$xpl->main_loop();

# The callback to log the incoming messages
sub log {
	my %p = @_;
	my $msg = $p{message};
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

	# Ex. de trame : xpl-stat/sensor.basic: bnz-rfxcomrx.bd5520524470 -> * thgr228n.4d/temp/15.6
	my ($ligne) = $msg->summary;

	if ($ligne =~ m/hbeat/) {
	  print "Skipping heartbeat \n";
	} else {
	  print "$mday/$mon/$year $hour:$min:$sec About to process [$ligne]\n";
  	  $ligne =~ m/.*\> \* (.*)/;
	  my $id;
	  my $attribute;
	  my $value;
	  my $dummy;
          ($id, $attribute, $value, $dummy) = split /\//, $1, 4;
	  # print "  id [$id]\n";
	  # print "  att [$attribute]\n";
	  # print "  value [$value]\n";
	  # if (defined $dummy) {
          #   print "  misc [$dummy]\n";
          # }
	  my $final_id = $id =~ s/\./\//r;
          my $topic = "metrics/rfxcom/$final_id/$attribute";
 	  print "$mday/$mon/$year $hour:$min:$sec Pushing on [$topic], value [$value]\n";
	  # $mqtt->publish("$topic", "$value");
          my $cv = $mqtt->publish(message => $value, topic => $topic, qos => 1);
          $cv->recv; # sent
	}
}
