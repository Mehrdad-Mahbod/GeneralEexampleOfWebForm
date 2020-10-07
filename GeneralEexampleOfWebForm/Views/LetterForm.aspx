<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LetterForm.aspx.cs" Inherits="Views_LetterForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var FilesTbl;

        $(window).resize(function () {
            FilesTbl.api().columns.adjust().draw();
            FilesTbl.api().draw(true);
        });


        $("document").ready(function () {
            var MyData = [
                {
                    'ID': '1',
                    'FileName': 'فایل اول',
                    'Extension': 'word',
                },
                {
                    'ID': '2',
                    'FileName': 'فایل دوم',
                    'Extension': 'pdf',
                }
            ];

            var Columns = [
                { 'data': 'ID', "name": 'Col0', "width": "10%", "targets": 0, "visible": true },
                { 'data': 'FileName', "name": 'Col1', "width": "70%", "targets": 1, "visible": true },
                { 'data': 'Extension', "name": 'Col2', "width": "10%", "targets": 2, "visible": true },
                {
                    "className": "dt-center",
                    //"mDataProp": null,
                    "data": null,
                    "width": "10%",
                    "visible": true,
                    "defaultContent": "<a style='' href='javascript:void(0)' id='BtnDelete'><i style='margin:0 5% 0 5%' class='fa fa-minus-circle fa-lg'></i></a>",
                    "targets": 3
                },
            ]

            FilesTbl = $('#FilesTbl').dataTable({
                "responsive": true,
                "dom": "ZTt<'row DTTTFooter'<'col-xs-10 toolbar'><'col-xs-2'l>>",
                "sRowSelect": "single",
                "info": true,
                "aaSorting": [[0, 'asc']],
                "aLengthMenu": [
                    [5, 10, 50, -1],
                    [5, 10, 50, "All"]
                ],
                "iDisplayLength": 50,
                //"sScrollX": "100%",/*اگر فعال باشد ستون ها به هم می ریزند*/
                "sScrollY": "280px",//280px
                "bscrollCollapse": true,
                "bSort": false,
                "bSortCellsTop": false,
                "bAutoWidth": true,
                "columnDefs": Columns,
                "scroller": true,
                "keys": true,
                "oTableTools":
                {

                    "aButtons": [

                    ],
                    "sSwfPath": "assets/swf/copy_csv_xls_pdf.swf"
                },
                "navigation": true,
                "language": {
                    "search": "",
                    "sLengthMenu": "_MENU_",
                    "oPaginate": {
                        "sPrevious": "قبلی",
                        "sNext": "بعدی",
                        "sLast": "آخرین",
                        "sFirst": "اولین"
                    },
                    "sZeroRecords": "هیچ داده ای برای نمایش یافت نشد"
                },
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Persian.json"
                },
                "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    //page number
                    var info = this.fnPagingInfo();
                    if (info.iTotalPages === 0) {
                        $('#pagetotal').val(1);
                    }
                    else {
                        $('#pagetotal').val(info.iTotalPages);
                    }
                    $('#pagenumber').val(info.iPage + 1);
                    //"sScrollY": "315px",
                },
                "fnDrawCallback": function (oSettings) {
                    var info = this.fnPagingInfo();
                    var pages = info.iTotalPages;
                    var currentpage = info.iPage;
                    if (currentpage == 0) {
                        $('#prev').prop("disabled", true);
                        $('#next').prop("disabled", false);
                    }
                    else if (currentpage == pages - 1) {
                        $('#prev').prop("disabled", false);
                        $('#next').prop("disabled", true);
                    }
                    else {
                        $('#prev').prop("disabled", false);
                        $('#next').prop("disabled", false);
                    }
                    if (pages == 0 || pages == 1) {
                        $('#prev').prop("disabled", true);
                        $('#next').prop("disabled", true);
                    }
                },
            });

            $("div.toolbar").html('<button type="button"  id="prev"  class="btn btn-default" style="margin-right:0; margin-left:3px">قبل</button><input type="text" class="form-control filterbox"  style="width:30px; text-align:center; display:inline-block;line-height:32px;height:32px;padding:5px 3px;font-size:12px;line-height:1.5;border-radius:2px !important; margin:0"  name="pagenumber" id="pagenumber" ><input id="Text2"  type="text" value="از" style="border-style:none; width:15px; text-align:center; background-color:rgb(245, 245, 245); display:inline-block" disabled="disabled; " /><input type="text" class="form-control filterbox" style="width:30px; text-align:center; display:inline-block;line-height:32px;height:32px;padding:5px 3px;font-size:12px;line-height:1.5;border-radius:2px !important;margin:0" name="pagetotal" id="pagetotal" disabled="disabled; "><button type="button" id="next"  class="btn btn-default" style="margin-right:3px; margin-left:0">بعد</button>');

            FilesTbl.dataTable().fnAddData(MyData);

            /*thead th Events***********************************************************************************************************************************************/
            $(FilesTbl.api().table().container()).on('click', 'thead th', function (ev) {
                console.log('click thead th');
                $('#FilesTbl').focus();
            });
            $(FilesTbl.api().table().container()).on('mousedown', 'thead th', function (ev) {
                console.log('mousedown thead th');
                $('#FilesTbl').focus();
            });
            $(FilesTbl.api().table().container()).on('click', 'thead tr', function (ev) {
                console.log('click thead tr');
                console.log(ev.keyCode);
                if (ev.keyCode == 33 || ev.keyCode === 34 || ev.keyCode === 37 || ev.keyCode === 38 || ev.keyCode === 39 || ev.keyCode === 40) {
                    ev.preventDefault();

                    console.log(ev.keyCode);

                    var dt = FilesTbl.api();
                    var pageInfo = dt.page.info();
                    var rows = pageInfo.recordsDisplay;
                    var end = pageInfo.end;
                    var start = pageInfo.start;
                    var currentpage = pageInfo.page;
                    var len = pageInfo.length;
                    var pages = pageInfo.pages;
                    var row = FocusedRowIndex;

                    var container = $('.dataTables_scrollBody');

                    //page up
                    if (ev.keyCode === 33) {

                    }
                    //page down
                    if (ev.keyCode === 34) {

                    }
                    //arrow up
                    if (ev.keyCode === 38) {
                    }
                    //arrow down
                    if (ev.keyCode === 40) {

                    }
                }
                if (ev.keyCode == 13) {

                }
            });
            /*End***********************************************************************************************************************************************************/

            /*Thead input Events********************************************************************************************************************************************/
            $(FilesTbl.api().table().container()).on('click', 'thead input', function () {
                console.log('click thead input');
                var FilesTblApi = FilesTbl.api();
                FilesTblApi.$('tr.selected').removeClass('selected');
                FilesTblApi.cell.blur();
                FilesTblApi.draw(false);
            });
            $(FilesTbl.api().table().container).on('keydown', 'thead input', function (Ev) {
                //console.log('keydown thead input');
                if (Ev.keyCode === 40) //Down Arrow
                {
                    console.log("Down Arrow");
                }
            });
            $(FilesTbl.api().table().container).on('keyup', 'thead input', function () {
                //console.log('keyup thead input');
                FilesTbl.api().column($(this).data('index')).search(this.value).draw();
            });
            /*End***********************************************************************************************************************************************************/

            /*Thead tbody Events********************************************************************************************************************************************/
            $(FilesTbl.api().table().container).on('click', 'tbody tr', function () {
                var Table = $('#FilesTbl').DataTable();
                //var Table = FilesTbl.api();

                Table.$('tr.selected').removeClass('selected');
                //TblApi.cell.blur();
                $(this).addClass('selected');
                var SelectedRow = Table.$('tr.selected');
                var SelectedRowIndex = SelectedRow.index();
                var Data = FilesTbl.fnGetData(SelectedRow);

                //console.log(Data);
                //FilesTbl.api().clear().draw();
            });
            $(FilesTbl.api().table().container).on('click', 'tbody tr td', function () {
                //var Table = $('#FilesTbl').DataTable();
                var Table = FilesTbl.api();

                var RowIndex = Table.cell(this).index().row;

                if (Table.cell(this).index().columnVisible == 0) {
                    //alert("دیتا= " + Table.cell(this).data() + " , سطر= " + Table.cell(this).index().row + " , ستون= " + Table.cell(this).index().columnVisible);
                    var CurrentRowData = Table.row(RowIndex).data();
                    console.log(CurrentRowData.ID);
                }

            });



            $('#FilesTbl tbody').on('click', '#BtnDelete', function () {
                //e.preventDefault();
                //var $Table = $('#FilesTbl').DataTable();
                var $Table = FilesTbl.api();

                var ClosestRow = $(this).closest('tr');
                var Data = $Table.row(ClosestRow).data();

                //console.log(Data);
            });


        });



       



    </script>

    <table tabindex="0" class='table table-striped table-hover table-bordered' id="FilesTbl">
        <thead>
            <tr>
                <th style='text-align: center;'>کد فایل</th>
                <th style='text-align: center;'>نام فایل</th>
                <th style='text-align: center;'>پسوند فایل</th>
                <th style='text-align: center;'>حذف فایل</th>
            </tr>
            <tr>
                <td>
                    <input type='text' name='Col0' id="Col0" class='form-control filterbox' style='width: 100%' data-index='0' />
                </td>
                <td>
                    <input type='text' name='Col1' id="Col1" class='form-control filterbox' style='width: 100%' data-index='1' />
                </td>
                <td>
                    <input type='text' name='Col2' id="Col2" class='form-control filterbox' style='width: 100%' data-index='2' />
                </td>
                <td>
                    <input type='text' name='Col3' id="Col3" class='form-control filterbox' style='width: 100%' data-index='3' />
                </td>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

</asp:Content>

