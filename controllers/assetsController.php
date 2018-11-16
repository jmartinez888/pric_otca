<?php


class assetsController extends Controller
{
    //put your code here


    public function __construct($lang,$url)
    {
        parent::__construct($lang,$url);
    }

    public function index()
    {
        throw new Exception('Contenido no disponible');
    }

    public function js ($file) {
        // header('Content-type: application/javascript');
        switch ($file) {
            case 'datatable_utils.js':
              $lenguaje = $this->_view->getLenguaje('datatables');
              $this->_view->render('datatable_utils');
              break;
            case 'datatables_lang.js':
                $this->_view->setShowError(false);
                $lenguaje = $this->_view->LoadLenguaje('datatables');
                // dd($lenguaje);
                // "decimal":        "",
               //  "emptyTable":     "No data available in table",
               //  "info":           "Showing _START_ to _END_ of _TOTAL_ entries",
               //  "infoEmpty":      "Showing 0 to 0 of 0 entries",
               //  "infoFiltered":   "(filtered from _MAX_ total entries)",
               //  "infoPostFix":    "",
               //  "thousands":      ",",
               //  "lengthMenu":     "Show _MENU_ entries",
               //  "loadingRecords": "Loading...",
               //  "processing":     "Processing...",
               //  "search":         "Search:",
               //  "zeroRecords":    "No matching records found",
               //  "paginate": {
               //      "first":      "First",
               //      "last":       "Last",
               //      "next":       "Next",
               //      "previous":   "Previous"
               //  },
               //  "aria": {
               //      "sortAscending":  ": activate to sort column ascending",
               //      "sortDescending": ": activate to sort column descending"
               //  }
                $values = [
                    'decimal' => isset($lenguaje['dt_decimal']) ? $lenguaje['dt_decimal'] : 'dt_decimal' ,
                    'emptyTable' => isset($lenguaje['dt_empty_table']) ? $lenguaje['dt_empty_table'] : 'dt_empty_table' ,
                    'info' => isset($lenguaje['dt_info']) ? $lenguaje['dt_info'] : 'dt_info' ,
                    'infoEmpty' => isset($lenguaje['dt_info_empty']) ? $lenguaje['dt_info_empty'] : 'dt_info_empty' ,
                    'infoFiltered' => isset($lenguaje['dt_info_filtered']) ? $lenguaje['dt_info_filtered'] : 'dt_info_filtered' ,
                    'infoPostFix' => isset($lenguaje['dt_info_post_fix']) ? $lenguaje['dt_info_post_fix'] : 'dt_info_post_fix' ,
                    'thousands' => isset($lenguaje['dt_thousands']) ? $lenguaje['dt_thousands'] : 'dt_thousands' ,
                    'lengthMenu' => isset($lenguaje['dt_length_menu']) ? $lenguaje['dt_length_menu'] : 'dt_length_menu' ,
                    'loadingRecords' => isset($lenguaje['dt_loading_records']) ? $lenguaje['dt_loading_records'] : 'dt_loading_records' ,
                    'processing' => isset($lenguaje['dt_processing']) ? $lenguaje['dt_processing'] : 'dt_processing' ,
                    'search' => isset($lenguaje['dt_search']) ? $lenguaje['dt_search'] : 'dt_search' ,
                    'zeroRecords' => isset($lenguaje['dt_zero_records']) ? $lenguaje['dt_zero_records'] : 'dt_zero_records' ,
                    'paginate' => [
                        'first' => isset($lenguaje['dt_paginate_first']) ? $lenguaje['dt_paginate_first'] : 'dt_paginate_first' ,
                        'last' => isset($lenguaje['dt_paginate_last']) ? $lenguaje['dt_paginate_last'] : 'dt_paginate_last' ,
                        'next' => isset($lenguaje['dt_paginate_next']) ? $lenguaje['dt_paginate_next'] : 'dt_paginate_next' ,
                        'previous' => isset($lenguaje['dt_paginate_previous']) ? $lenguaje['dt_paginate_previous'] : 'dt_paginate_previous'
                    ],
                    'aria' => [
                        'sortAscending' => isset($lenguaje['dt_aria_sort_asc']) ? $lenguaje['dt_aria_sort_asc'] : 'dt_aria_sort_asc' ,
                        'sortDescending' => isset($lenguaje['dt_aria_sort_des']) ? $lenguaje['dt_aria_sort_des'] : 'dt_aria_sort_des'
                    ]
                ];
                echo 'var datatables_lenguaje = '.json_encode($values).';';
                break;
        }
    }
}
