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
        header('Content-type: application/javascript');
        switch ($file) {
            case 'datatables_lang.js':

                $lenguaje = $this->_view->LoadLenguaje('datatables');
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
                    'decimal' => $lenguaje['dt_decimal'],
                    'emptyTable' => $lenguaje['dt_empty_table'],
                    'info' => $lenguaje['dt_info'],
                    'infoEmpty' => $lenguaje['dt_info_empty'],
                    'infoFiltered' => $lenguaje['dt_info_filtered'],
                    'infoPostFix' => $lenguaje['dt_info_post_fix'],
                    'thousands' => $lenguaje['dt_thousands'],
                    'lengthMenu' => $lenguaje['dt_length_menu'],
                    'loadingRecords' => $lenguaje['dt_loading_records'],
                    'processing' => $lenguaje['dt_processing'],
                    'search' => $lenguaje['dt_search'],
                    'zeroRecords' => $lenguaje['dt_zero_records'],
                    'paginate' => [
                        'first' => $lenguaje['dt_paginate_first'],
                        'last' => $lenguaje['dt_paginate_last'],
                        'next' => $lenguaje['dt_paginate_next'],
                        'previous' => $lenguaje['dt_paginate_previous']
                    ],
                    'aria' => [
                        'sortAscending' => $lenguaje['dt_aria_sort_asc'],
                        'sortDescending' => $lenguaje['dt_aria_sort_des']
                    ]
                ];
                echo 'var datatables_lenguaje = '.json_encode($values).';';
                break;
        }
    }
}
