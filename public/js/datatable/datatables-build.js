function getDatatable (target, url, cb_filter, columns, columnsDef, pageLength = 10) {
  return  $(target).DataTable({
    language: datatables_lenguaje,
    ajax: {
      url: url,
      data: cb_filter
    },
    dom: '<"table-responsive"t>p',
    pageLength: pageLength,
    serverSide: true,
    columns: columns,
    columnDefs: columnsDef
  })
}