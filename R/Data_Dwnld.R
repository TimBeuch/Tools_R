#' Work in progress copié de https://github.com/Pakillo/rmdTemplates/blob/master/R/embed_data_html.R
#'
#' @param dataset data
#' @param textHTML text
#' @import base64enc
#'
#' @return
#' @export
data_html <-  function(dataset, textHTML = "Click here to download the data"){

  divname <- paste(sample(LETTERS), collapse="")
  tf <- tempfile(pattern = dataset, fileext = "RData")
  save(list = dataset, file = tf, envir = parent.frame())
  filenameWithExt <- paste(dataset, "RData", sep=".")

  uri <- base64enc::dataURI(file = tf, mime = "application/octet-stream", encoding = "base64")
  cat("<a style='text-decoration: none' id='",divname,"'></a>
      <script>
      var a = document.createElement('a');
      var div = document.getElementById('",divname,"');
      div.appendChild(a);
      a.setAttribute('href', '",uri,"');
      a.innerHTML = '",textHTML,"' + ' (",filenameWithExt,")';
      if (typeof a.download != 'undefined') {
      a.setAttribute('download', '",filenameWithExt,"');
      }else{
      a.setAttribute('onclick', 'confirm(\"Your browser does not support the download HTML5 attribute. You must rename the file to ",filenameWithExt," after downloading it (or use Chrome/Firefox/Opera). \")');
      }
      </script>",
      sep="")
}
