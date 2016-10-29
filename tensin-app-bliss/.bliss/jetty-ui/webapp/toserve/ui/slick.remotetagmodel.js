(function ($) {
  /***
   * A sample AJAX data store implementation.
   * Right now, it's hooked up to load all Apple-related Digg stories, but can
   * easily be extended to support and JSONP-compatible backend that accepts paging parameters.
   */
  function RemoteModel() {
	var fromPage=0;
    // private
    var PAGESIZE = 50;
    var data = {length: 0};
    var searchstr = "";
    var sortcol = null;
    var sortdir = 1;
    var h_request = null;
    var req = null; // ajax request

    // events
    var onDataLoading = new Slick.Event();
    var onDataLoaded = new Slick.Event();


    function init() {
    }


    function getLength() {
    	return data.length;
    }
    
    function isDataLoaded(from, to) {
      for (var i = from; i <= to; i++) {
        if (data[i] == undefined || data[i] == null) {
          return false;
        }
      }

      return true;
    }


    function clear() {
      for (var key in data) {
        delete data[key];
      }
      data.length = 0;
    }


    /*
     * Load data for the specified rows if no data is already loaded
     */
    function ensureData(from, to, dontRequireUndefined) {
      if (req) {
        req.abort();
        for (var i = req.fromPage; i <= req.toPage; i++)
          data[i * PAGESIZE] = undefined;
      }

      if (from < 0) {
        from = 0;
      }

      var fromPage = Math.floor(from / PAGESIZE);
      var toPage = Math.floor(to / PAGESIZE);

      while (data[fromPage * PAGESIZE] !== undefined && fromPage < toPage)
        fromPage++;

      while (data[toPage * PAGESIZE] !== undefined && fromPage < toPage)
        toPage--;

      if (fromPage > toPage || (!dontRequireUndefined && ((fromPage == toPage) && data[fromPage * PAGESIZE] !== undefined))) {
        // TODO:  look-ahead
        return;
      }

      var searchPart="";
      if(searchstr) {
    	  searchPart = "query=" + encodeURIComponent(searchstr) + "&";
      }
    	  
      var url = "/api/storageNode?" + searchPart + 
      	"iDisplayStart=" + (fromPage * PAGESIZE) + 
      	"&iDisplayLength=" + (((toPage - fromPage) * PAGESIZE) + PAGESIZE) +
      	"&iSortCol_0=0";

      if (h_request != null) {
        clearTimeout(h_request);
      }

      h_request = setTimeout(function () {
        for (var i = fromPage; i <= toPage; i++)
          data[i * PAGESIZE] = null; // null indicates a 'requested but not available yet'

        onDataLoading.notify({from: from, to: to});

        req = $.ajax({
          url: url,
          dataType: "json",
          success: onSuccess,
          error: function () {
            onError(fromPage, toPage)
          },
          fromPage: fromPage,
          toPage: toPage
        });
        req.fromPage = fromPage;
        req.toPage = toPage;
      }, 50);
    }

    function update(cell, args, onFail) {
    	$.ajax({
            type: "POST",
            url: "/api/storageNode",
            data: JSON.stringify(args),
            contentType: "application/json",
            dataType: "json",
            success: onPostSuccess,
            error: function(jqXHR, textStatus, errorThrown) {
            	onFail(cell, jqXHR, textStatus, errorThrown)
            }
      });
    }
    
    function onPostSuccess(data) {
    	
    }

    function onError(fromPage, toPage) {
      //alert("error loading pages " + fromPage + " to " + toPage);
    }

    function onSuccess(resp) {
      var from = this.fromPage * PAGESIZE, to = from + resp.count;
      data.length = parseInt(resp.total);

      for (var i = 0; i < resp.aaData.length; i++) {
        data[from + i] = resp.aaData[i];
        data[from + i].index = from + i;
      }

      req = null;

      onDataLoaded.notify({from: from, to: to});
    }


    function reloadData(from, to) {
      for (var i = from; i <= to; i++)
        delete data[i];

      ensureData(from, to);
    }

    function setSort(column, dir) {
      sortcol = column;
      sortdir = dir;
      clear();
    }

    function setSearch(str) {
      searchstr = str;
      clear();
    }


    init();

    return {
      // properties
      "data": data,

      // methods
      "clear": clear,
      "isDataLoaded": isDataLoaded,
      "ensureData": ensureData,
      "reloadData": reloadData,
      "setSort": setSort,
      "setSearch": setSearch,
      "update": update,

      // events
      "onDataLoading": onDataLoading,
      "onDataLoaded": onDataLoaded
    };
  }

  // Slick.Data.RemoteModel
  $.extend(true, window, { Slick: { Data: { RemoteModel: RemoteModel }}});
})(jQuery);