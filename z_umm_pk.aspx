<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_umm_pk');

            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_umm_pk',
                    options : [{
                        type : '2', //[1][2]  1
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '1', //[3][4]  2
                        name : 'xdate'
                    }, {
                        type : '1', //[5][6]  3
                        name : 'xummdate'
                    }, {
                        type : '1', //[7][8]  4
                        name : 'xmon'
                    }, {
                        type : '6', //[9]   5
                        name : 'xmemo1'
                    }, {
                        type : '6', //[10]   6
                        name : 'xmemo2'
                    }, {
                        type : '6', //[11]   7
                        name : 'xmemo3'
                    }, {
                        type : '6', //[12]   8
                        name : 'xmemo4'
                    }, {
                        type : '6', //[13]   9
                        name : 'xmemo5'
                    }, {
						type : '8', //[14] 10
						name : 'xispayed',
						value : "1@顯示已收".split(',')
					}, {
						type : '8', //[15] 11
						name : 'xisunpay',
						value : "1@顯示未收".split(',')
					}, {
						type : '8', //[16] 12
						name : 'xisweight',
						value : "1@顯示重量".split(',')
					}, {
						type : '8', //[17] 13
						name : 'xistotal',
						value : "1@顯示應收總計".split(',')
					}]
                });
                q_popAssign();
                q_langShow();
                
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                $('#txtXummdate1').mask('999/99/99');
                $('#txtXummdate1').datepicker();
                $('#txtXummdate2').mask('999/99/99');
                $('#txtXummdate2').datepicker();
                
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                //--------------------------------
                $('#Xmemo1').css('width','98%');
                $('#txtXmemo1').css('width','80%');
                $('#Xmemo2').css('width','98%');
                $('#txtXmemo2').css('width','80%');
                $('#Xmemo3').css('width','98%');
                $('#txtXmemo3').css('width','80%');
                $('#Xmemo4').css('width','98%');
                $('#txtXmemo4').css('width','80%');
                $('#Xmemo5').css('width','98%');
                $('#txtXmemo5').css('width','80%');
                
                $('#chkXispayed input[type="checkbox"]').prop("checked",true);
                $('#chkXisunpay input[type="checkbox"]').prop("checked",true);
                $('#chkXisweight input[type="checkbox"]').prop("checked",true);
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    default:
                        break;
                }
            }

		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>