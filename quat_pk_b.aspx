<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
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
            var q_name = "quat_orde", t_content = "where=^^['','')^^", bbsKey = ['noa','no3'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.ordeno+"','"+t_para.custno+"','"+t_para.page+"')^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						//if (isLoadGt == 1) {
							abbs = _q_appendData(q_name, "", true);
							isLoadGt = 0;
							refresh();
						//}
						break;
				}
			}

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>


		
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:8%;">單號</td>
					<td align="center" style="width:10%;">品名</td>
					<td align="center" style="width:4%;">厚</td>
					<td align="center" style="width:4%;">寬</td>
					<td align="center" style="width:4%;">長</td>
					<td align="center" style="width:4%;">短徑</td>
					<td align="center" style="width:5%;">規格</td>
					<td align="center" style="width:4%;">數量<BR>單位</td>
					<td align="center" style="width:4%;">重量<BR>單位</td>
					<td align="center" style="width:4%;">單價</td>
					<td align="center" style="width:8%;">備註</td>
					<td align="center" style="width:5%;">已訂數量<BR>已訂重量</td>
					<td align="center" style="width:5%;">未訂數量<BR>未訂重量</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"></th>
					<td align="center" style="width:8%;">單號</td>
					<td align="center" style="width:10%;">品名</td>
					<td align="center" style="width:4%;">厚</td>
					<td align="center" style="width:4%;">寬</td>
					<td align="center" style="width:4%;">長</td>
					<td align="center" style="width:4%;">短徑</td>
					<td align="center" style="width:5%;">規格</td>
					<td align="center" style="width:4%;">數量<BR>單位</td>
					<td align="center" style="width:4%;">重量<BR>單位</td>
					<td align="center" style="width:4%;">單價</td>
					<td align="center" style="width:8%;">備註</td>
					<td align="center" style="width:5%;">已訂數量<BR>已訂重量</td>
					<td align="center" style="width:5%;">未訂數量<BR>未訂重量</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:8%;">
						<input id="txtAccy.*" type="text" style="display:none;"  readonly="readonly" />
						<input id="txtNoa.*" type="text" style="float:left;width:75%;"  readonly="readonly" />
						<input id="txtNo3.*" type="text" style="float:left;width:15%;"  readonly="readonly" />
					</td>
					<td style="width:10%;">
						<input id="txtProductno.*" type="text" style="float:left;width:95%;"  readonly="readonly" />
						<input id="txtProduct.*" type="text" style="float:left;width:95%;"  readonly="readonly" />
					</td>
					<td style="width:4%;"><input id="txtDime.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:4%;"><input id="txtRadius.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:4%;"><input id="txtWidth.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:4%;"><input id="txtLengthb.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtSpec.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:4%;">
						<input id="txtMount.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
						<input id="txtUnit2.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:4%;">
						<input id="txtWeight.*" type="text" style="float:left;width:100%;"   readonly="readonly" />
						<input id="txtUnit.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:4%;"><input id="txtPrice.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:8%;"><input id="txtMemo.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;">
						<input id="txtOmount.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
						<input id="txtOweight.*" type="text" style="float:left;width:100%;"   readonly="readonly" />
					</td>
					<td style="width:5%;">
						<input id="txtEmount.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
						<input id="txtEweight.*" type="text" style="float:left;width:100%;"   readonly="readonly" />
					</td>
					
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

