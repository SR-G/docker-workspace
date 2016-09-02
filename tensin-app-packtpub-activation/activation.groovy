/**
 * @author Bahman Movaqar <Bahman AT BahmanM.com>
 */
@Grab('org.jsoup:jsoup:1.8.2')
import static org.jsoup.Jsoup.parse

def paramEmail = args[0]
def paramPassword = args[1]

def cookieManager = new CookieManager(null, CookiePolicy.ACCEPT_ALL)
CookieHandler.setDefault(cookieManager)
def doc = parse(
  new URL('https://www.packtpub.com/packt/offers/free-learning').text
)
2.times { // a weird hack! to make this work on slow connections
  doLogin(
    loginParams(doc.select('input[type=hidden][id^=form][value^=form]')?.val(), paramEmail, paramPassword)
  )
}
claimBook(
  doc.select('a.twelve-days-claim').attr('href'),
  CookieHandler.getDefault().cookieStore.cookies
)
println('Claimed! Login to Packt website to download the book.')

///////////////////////////////////////////////////////////////////////////////
def loginParams(formBuildId, paramEmail, paramPassword) {
  [
    email: paramEmail,
    password: paramPassword,
    op: 'Login', 
    form_id: 'packt_user_login_form',
    form_build_id: formBuildId ?: ''
  ].findAll { k, v -> v }.collect { k, v -> 
    "$k=${URLEncoder.encode(v, 'UTF8')}"
  }.join('&')
}

///////////////////////////////////////////////////////////////////////////////
def doLogin(loginParams) {
  new URL(
    'https://www.packtpub.com/packt/offers/free-learning'
  ).openConnection().with {
    requestMethod = 'POST'
    setRequestProperty('Content-Type', 'application/x-www-form-urlencoded')
    doOutput = true
    doInput = true
    allowUserInteraction = true
    outputStream.withWriter { w -> w << loginParams }
    connect()
    if (parse(inputStream.text).select('div.error'))
      throw new Exception("Failed to login.")
  }
}

///////////////////////////////////////////////////////////////////////////////
def claimBook(bookUrl, cookies) {
  new URL(
    "https://www.packtpub.com${bookUrl}"
  ).openConnection().with {
    requestMethod = 'GET'
    cookies.each { setRequestProperty('Cookie', it.toString()) }
    connect()
    content
  }
}


