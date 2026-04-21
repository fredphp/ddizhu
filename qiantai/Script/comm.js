function openWindowOwn(url, name, width, height) {
    var left = (window.screen.availWidth - width) / 2;
    var top = (window.screen.availHeight - height) / 2
    var openthiswin = window.open(url, name, 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,left=' + left + ',top=' + top + ',width=' + width + ',height=' + height);
    if (openthiswin != null) openthiswin.focus();
}