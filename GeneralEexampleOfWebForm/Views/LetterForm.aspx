<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LetterForm.aspx.cs" Inherits="Views_LetterForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

    <script type="text/javascript">

        var FilesTbl;

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
                { 'data': 'ID', "name": 'Col0', "width": "50%", "targets": 0, "visible": false },
                { 'data': 'FileName', "name": 'Col1', "width": "80%", "targets": 1, "visible": true },
                { 'data': 'Extension', "name": 'Col2', "width": "45%", "targets": 2, "visible": false },
                {
                    "className": "dt-center",
                    "mDataProp": null,
                    "visible": true,
                    "defaultContent": "<a style='' href='javascript:void(0)' id='BtnDelete'><i style='margin:0 5% 0 5%' class='fa fa-minus-circle fa-lg'></i></a>",
                    "targets": 3
                },
            ]
            FilesTbl = $('#FilesTbl').dataTable({
                "data":MyData,
                "dom": "ZTt<'row DTTTFooter'<'col-xs-10 toolbar'><'col-xs-2'l>>",
                "sRowSelect": "single",
                "info": false,
                "aaSorting": [[0, 'asc']],
                "aLengthMenu": [
                    [5, 10, 50, -1],
                    [5, 10, 50, "All"]
                ],
                "iDisplayLength": 50,
                "sScrollX": "100%",
                "sScrollY": "280px",//280px
                "bscrollCollapse": true,
                "bSortCellsTop": true,
                "bAutoWidth": false,
                "columnDefs": Columns,
                "scroller": true,
                "keys": true,
                "oTableTools":
                {

                    "aButtons": [

                    ],
                    "sSwfPath": "assets/swf/copy_csv_xls_pdf.swf"
                },
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
                "navigation": true,
                // Index Column(Radif)
                "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    //page number
                    var info = this.fnPagingInfo();
                    //if (info.iTotalPages === 0) {
                    //    $('#pagetotal').val(1);
                    //}
                    //else {
                    //    $('#pagetotal').val(info.iTotalPages);
                    //}
                    //$('#pagenumber').val(info.iPage + 1);
                    //"sScrollY": "315px",
                },
                "fnDrawCallback": function (oSettings) {
                    var info = this.fnPagingInfo();
                    var pages = info.iTotalPages;
                    var currentpage = info.iPage;

                },
            });
            //FilesTbl.api().columns.adjust().draw();
            //$("div.toolbar").html('<button type="button"  id="prev"  class="btn btn-default" style="margin-right:0; margin-left:3px">قبل</button><input type="text" class="form-control filterbox"  style="width:30px; text-align:center; display:inline-block;line-height:32px;height:32px;padding:5px 3px;font-size:12px;line-height:1.5;border-radius:2px !important; margin:0"  name="pagenumber" id="pagenumber" ><input id="Text2"  type="text" value="از" style="border-style:none; width:15px; text-align:center; background-color:rgb(245, 245, 245); display:inline-block" disabled="disabled; " /><input type="text" class="form-control filterbox" style="width:30px; text-align:center; display:inline-block;line-height:32px;height:32px;padding:5px 3px;font-size:12px;line-height:1.5;border-radius:2px !important;margin:0" name="pagetotal" id="pagetotal" disabled="disabled; "><button type="button" id="next"  class="btn btn-default" style="margin-right:3px; margin-left:0">بعد</button>');


        });
    </script>
</asp:Content>

