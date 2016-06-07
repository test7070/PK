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
            var q_name = "ordc_import", t_content = "where=^^['','')^^", bbsKey = ['noa','no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var bbsNum = [['txtCnt', 2, 0, 1]];
       		brwCount = -1;
			brwCount2 = -1;
			t_spec='';
			
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
	            	t_content = "where=^^['"+t_para.tggno+"','"+t_para.kind+"','"+t_para.noa+"','"+t_para.page+"')^^";
	            }catch(e){
	            } 
	            brwCount = -1;
	            mainBrow(0, t_content); 
            }
            function q_gtPost(t_name) {
				switch (t_name) {
					/*case q_name:
						abbs = _q_appendData(q_name, "", true);
						refresh();
						break;*/
				}
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
            
            function refresh() {
                _refresh();
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text(i+1);
				}
            }
            function bbsAssign() {
				
                	
				_bbsAssign();
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:1250;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:25px;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:30px;"> </td>
					<td align="center" style="width:80px;">交貨日期</td>
					<td align="center" style="width:100px;">廠商</td>
					<td align="center" style="width:150px;">品名</td>
					<td align="center" style="width:70px;">等級<BR>鋼廠</td>
					<td align="center" style="width:70px;">規範<BR>國別</td>
					<td align="center" style="width:170px;">厚度x寬度x長度<BR>規格</td>
					<td align="center" style="width:120px;">尺寸<BR>備註</td>
					<td align="center" style="width:70px;">數量<BR>重量</td>
					<td align="center" style="width:80px;">數量單位<BR>計價單位</td>		
					<td align="center" style="width:60px;">單價</td>
					<td align="center" style="width:70px;">本次<BR>進貨數</td>
					<td align="center" style="width:100px;">採購單號</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:1250;' >
				<tr style="display:none;">
					<th align="center" style="width:25px;"> </th>
					<td align="center" style="width:30px;"> </td>
					<td align="center" style="width:80px;">交貨日期</td>
					<td align="center" style="width:100px;">廠商</td>
					<td align="center" style="width:150px;">品名</td>
					<td align="center" style="width:70px;">等級<BR>鋼廠</td>
					<td align="center" style="width:70px;">規範<BR>國別</td>
					<td align="center" style="width:170px;">厚度x寬度x長度<BR>規格</td>
					<td align="center" style="width:120px;">尺寸<BR>備註</td>
					<td align="center" style="width:70px;">數量<BR>重量</td>
					<td align="center" style="width:80px;">數量單位<BR>計價單位</td>		
					<td align="center" style="width:60px;">單價</td>
					<td align="center" style="width:70px;">本次<BR>進貨數</td>
					<td align="center" style="width:100px;">採購單號</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:30px;text-align: center;"><a id="lblNo.*" style="font-weight: bold;" readonly="readonly"> </a></td>
					<td style="width:80px;"><input type="text" readonly="readonly" id="txtRdate.*" style="float:left;width:95%;"/></td>
					<td style="width:100px;"><input type="text" readonly="readonly" id="txtTgg.*" style="float:left;width:95%;"/></td>
					<td style="width:150px">
						<input type="text" readonly="readonly" id="txtProductno.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtProduct.*" style="float:left;width:95%;"/>
					</td>
					<td style="width:70px">
						<input type="text" readonly="readonly" id="txtClass.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtSource.*" style="float:left;width:95%;"/>
					</td>
					<td style="width:70px">
						<input type="text" readonly="readonly" id="txtUcolor.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtScolor.*" style="float:left;width:95%;"/>
					</td>
					<td style="width:170px">
						<input type="text" readonly="readonly" id="txtDime.*" style="float:left;width:40px;text-align: right;"/>
						<a style="float:left;width:15px;">X</a>
						<input type="text" readonly="readonly" id="txtWidth.*" style="float:left;width:40px;text-align: right;"/>
						<a style="float:left;width:15px;">X</a>
						<input type="text" readonly="readonly" id="txtLengthb.*" style="float:left;width:40px;text-align: right;"/>
						<input type="text" readonly="readonly" id="txtSpec.*" style="width:162px;"/>
					</td>
					<td style="width:120px">
						<input type="text" readonly="readonly" id="txtSize.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtMemo.*" style="float:left;width:95%;"/>
					</td>
					<td style="width:70px;">
						<input type="text" readonly="readonly" id="txtMount.*" style="float:left;width:95%;text-align: right;"/>
						<input type="text" readonly="readonly" id="txtWeight.*" style="float:left;width:95%;text-align: right;"/>
					</td>
					<td style="width:80px;">
						<input type="text" readonly="readonly" id="txtUnit2.*" style="float:left;width:95%;text-align: center;"/>
						<input type="text" readonly="readonly" id="txtUnit.*" style="float:left;width:95%;text-align: center;"/>
					</td>
					<td style="width:60px;"><input type="text" readonly="readonly" id="txtPrice.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:70px;background-color: pink;"><input type="text" id="txtCnt.*" class="txt num" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:100px;">
						<input type="text" readonly="readonly" id="txtNoa.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtNo2.*" style="float:left;width:95%;"/>
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

