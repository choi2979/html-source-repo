<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리 - [jEasyUI활용]</title>
<%@ include file="./JEasyUICommon.jsp" %>
    <script type="text/javascript">
    //여기가 전변자리이다.
    var g_address='';//사용자가 선택한 주소정보 담기
    function empINS(){
    	//insert here
    	$('#dlg_ins').dialog('open');
    }
    function empUPD(){
    	//insert here
    	$('#dlg_upd').dialog('open');
    }
    function empnoSearch(){
    	//alert("empnoSearch 호출");
    	var s_empno = $("#s_empno").val();
    	$("#dg_emp").datagrid({
    		url:'jsonEmpList.jsp?empno='+s_empno
    	});
    }
    function empList(){
		$('#dg_emp').datagrid({
			url:"jsonEmpList.jsp"
			,onLoadSuccess: function(data){
				var result = JSON.stringify(data);
				alert("새로고침 처리 성공: "+data+", "+result);
			}			
		});
	}
    ///////////////////////////////////DataGrid에 직접 수정 모드 추가하기////////////////////////////////////////////////
    function getRowIndex(target){
    	var tr = $(target).closest('tr.datagrid-row');
    	return parseInt(tr.attr('datagrid-row-index'));
	}
	function editrow(target){
    	$('#dg_emp').datagrid('beginEdit', getRowIndex(target));
	}
	function deleterow(target){
    	$.messager.confirm('Confirm','Are you sure?',function(r){
        	if (r){
            	$('#dg_emp').datagrid('deleteRow', getRowIndex(target));
        	}
    	});
	}
	function saverow(target){
    	$('#dg_emp').datagrid('endEdit', getRowIndex(target));
    	alert("target: "+target.EMPNO);
	}
	function cancelrow(target){
    	$('#dg_emp').datagrid('cancelEdit', getRowIndex(target));
	}
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    function zipcode_search(){
    	var u_dong = $("#dong").val();//사용자가 입력한 동이름이 담김
    	if(u_dong == null || u_dong.length<1){
    		alert("동을 입력하세요");
    		return;//여기서는 함수의 영역을 빠져나감.
    	}else{
    		$("#dg_zipcode").datagrid({
    			url:'jsonZipCodeList.jsp?dong='+u_dong
    		});
    	}
    }
    //사원 정보 등록 처리
    function emp_ins(){
    	//alert("저장");
    	//화면에서 입력받은 값은 http프로토콜을 이용해서 서버쪽으로 전송되는데 이 때 유니코드로 변환되어 전달됨.
    	//해결방법-server.xml문서에 포트번호 설정위치(63번라인) URIEncoding="UTF-8"
    	//단 get방식에만 적용됨. post방식일때는 java코드를 활용하여 별도처리
    	$("#f_ins").attr("method","get");
    	$("#f_ins").attr("action","empInsert.jsp");
    	$("#f_ins").submit();
    }
    //사원 정보 수정 처리
    function emp_upd(){
    	//alert("수정 저장");
    	$("#f_upd").attr("method","get");
    	$("#f_upd").attr("action","empUpdate.jsp");
    	$("#f_upd").submit();
    }
    </script>
</head>
<body>
<!-- =============================================== 검색 조건 추가하기 =========================================== -->
	<div id="tbar_emp">
		<form id="f_search">
			<table>
				<tr>
					<td width="190px">
						<label width="80px">사원번호</label>
						<input id="s_empno" name="s_empno" class="easyui-searchbox" data-options="prompt:'사원번호', searcher:empnoSearch" style="width:110px">
					</td>
				</tr>
				<tr>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">사원조회</a>
 	  					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="true" onclick="empINS()">사원등록</a>
 	       				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="empUPD()">사원수정</a>
  	      				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="empDEL()">사원삭제</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
<!-- =============================================== 검색 조건 추가하기 =========================================== -->
    <table id="dg_emp"></table>
	<script type="text/javascript">
		$(document).ready(function(){
			/* 동이름 입력 후 엔터 쳤을 때 처리하기 */
			var t = $('#dong');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){	// when press ENTER key, accept the inputed value.
					//alert("엔터");
					$("#dg_zipcode").datagrid({
		    			url:'jsonZipCodeList.jsp?dong='+$(this).val()
		    			,singleSelect:true
		    			//선택한 로우의 우편번호와 주소정보 읽어서 변수에 담기 처리
		    			//여기서 row는 사용자가 선택한 로우의 정보를 가짐.
		    			,onSelect:function(index,row){
		    				//아래에서 선택된 로우인지는 어떻게 아는 걸까?
		    				//alert(row.ADDRESS);
		    				g_address = row.ADDRESS;//필드명은 mybatis를 사용했으니까 꼭 대문자로 한다.
		    			},onDblClickCell:function(index,field, value){
		    				if("ZIPCODE"==field){//너 우편번호 셀(컬럼)을 선택한거니?
		    					//더블 클릭 이벤트 핸들러를 셀을 선택했으니까 세번째 파라미터의 value는
		    					//사용자가 선택한로우에 그 셀에 값을 가짐.
		    					$("#zipcode").textbox('setValue',value);
		    					$("#mem_addr").textbox('setValue',g_address);
		    					$("#dg_zipcode").datagrid("clearSelections");
		    					$("#dlg_zipcode").dialog('close');
		    				}
		    			}
						/* ,?:function(?){
							
						} */
		    		});
				}
			});
			/* 우편번호 찾기 목록 초기화*/
			$("#dlg_zipcode").dialog({
				width: 580
				,height: 550
				,title: '우편번호 검색기'
				,closed:true
			});
			$("#dg_zipcode").datagrid({
				title:'우편번호 찾기 검색 결과'
				,columns:[[
					{field:'ZIPCODE',title:'우편번호', width:100, align:'center'}
					,{field:'ADDRESS',title:'주소', width:400, align:'left'}
				]]
			});
			/* 우편번호 찾기 버튼*/
			$('#btn_zipcode').linkbutton({
				onClick:function(){
					$("#dlg_zipcode").dialog({
						closed: false
						,title: '우편번호 검색기'
					});
				}
			});
			$('#dlg_ins').dialog({
				modal:true
			});
			$('#dlg_upd').dialog({
				closed:true
			});
			$('#dg_emp').datagrid({
				toolbar:'#tbar_emp'
				,singleSelect:true
				,width: '1000px'
				,title:'사원관리 - 자바스크립트 만으로 구성하기'
			    ,columns:[[
			        {field:'CK', checkbox:true, width:50, align:'center'}
			        ,{field:'EMPNO',title:'사원번호',width:90,align:'center', editor:'numberbox'}
			        ,{field:'ENAME',title:'사원명',width:120,align:'center', editor:'text'}
			        ,{field:'JOB',title:'JOB',width:130,align:'center', editor:'text'}
			        ,{field:'HIREDATE',title:'입사일자',width:150,align:'center', editor:'text'}
			        ,{field:'MGR',title:'MGR',width:150,align:'center', editor:'numberbox', hidden:'true'}
			        ,{field:'SAL',title:'급여',width:110,align:'center', editor:'numberbox'}
			        ,{field:'COMM',title:'인센티브',width:100,align:'center', editor:'numberbox'}
			        ,{field:'DEPTNO',title:'부서번호',width:100,align:'center'
			        ,	editor:{
			        		type:'combobox'
			        		,options:{
			        			valueField:'DEPTNO'
			        			,textField:'DNAME'
			        			,url:'./jsonDeptList.jsp'
			        			,required:true
			        		}///////////// options
			        	}///////////////// editor
			        }
			        ,{field:'action',title:'Action',width:100,align:'center',
		                formatter:function(value,row,index){
		                    if (row.editing){
		                        var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
		                        var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
		                        return s+c;//'안녕'||'내일봐'
		                    } else {
		                        var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
		                        var d = '<a href="javascript:void(0)" onclick="deleterow(this)">Delete</a>';
		                        return e+d;
		                    }
		                }
		            }
			    ]]
			,
	        onEndEdit:function(index,row){
	            var ed = $(this).datagrid('getEditor', {
	                index: index,
	                field: 'productid'
	            });
	            row.productname = $(ed.target).combobox('getText');
	        },
	        onBeforeEdit:function(index,row){
	            row.editing = true;
	            $(this).datagrid('refreshRow', index);
	        },
	        onAfterEdit:function(index,row){
	            row.editing = false;
	            $(this).datagrid('refreshRow', index);
	        },
	        onCancelEdit:function(index,row){
	            row.editing = false;
	            $(this).datagrid('refreshRow', index);
	        },
	        onClickRow:function(index,row){
	        	alert("선택했네 ==>"+index+", "+row.EMPNO);
	        }
	        
/*
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">조회</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">Remove User</a>
*/
			});////////////////////////datagrid
		});///////////////////////////ready
	</script>
	<!-- ===================================================우편번호 찾기============================================================== -->
	<div id="dlg_zipcode" style="width:100%; max-width:600px; padding:30px 30px; ">
		<input class="easyui-textbox" id="dong" name="dong" labelPosition="top" data-options="prompt:'동이름이나 주소 정보 입력...'" style="width:210px;">
		<a id="btn_search" class="easyui-linkbutton" href="javascript: zipcode_search();" data-options="iconCls:'icon-search'">찾기</a><!-- 1.id활용 2.href활용 -->
		<div style="margin-bottom:10px;"></div>
		<table id="dg_zipcode"></table>
	</div>
	<!-- ===================================================우편번호 찾기============================================================== -->
	<!-- ========================================================사원 등록============================================================= -->
	<div id="dlg_ins" data-options="closed:true, title:'사원정보 등록', footer:'#d_ins', modal:'true'" class="easyui-dialog" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_ins">
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt:'Enter a EmpNO'" style="width:160px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt:'Enter a ENAME'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="job" name="job" label="JOB" labelPosition="top" data-options="prompt:'Enter a JOB'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="hiredate" name="hiredate" label="입사일자" labelPosition="top" data-options="prompt:'Enter a HIREDATE'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="sal" name="sal" label="급여" labelPosition="top" data-options="prompt:'Enter a SAL'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt:'Enter a COMM'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-combobox" id="deptno" name="deptno"  label="부서번호" style="width:250px" labelPosition="top" 
				data-options="prompt:'Enter a DEPTNO'
					,valueField: 'DEPTNO'
        			,textField: 'DNAME'
        			,url: './jsonDeptList.jsp'
        			,onSelect: function(rec){
        			}"
        		>
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt:'Enter a ZIPCODE'" style="width:100px">
				<a id="btn_zipcode" href="#" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소" data-options="prompt:'Enter a ADDRESS'" style="width:400px">
			</div>
		</form>
		<div id="d_ins" style="margin-bottom:10px">
			<a id="btn_save" href="javascript:emp_ins()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<a id="btn_close" href="javascript:$('#dlg_ins').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
	</div>
	<!-- ========================================================사원 등록============================================================= -->
	<!-- ========================================================사원 수정============================================================= -->
	<div id="dlg_upd" data-options="closed:true, title:'사원정보 수정', footer:'#d_upd', modal:'true'" class="easyui-dialog" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_udp">
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt:'Enter a EmpNO'" style="width:160px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt:'Enter a ENAME'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="job" name="job" label="JOB" labelPosition="top" data-options="prompt:'Enter a JOB'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="hiredate" name="hiredate" label="입사일자" labelPosition="top" data-options="prompt:'Enter a HIREDATE'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="sal" name="sal" label="급여" labelPosition="top" data-options="prompt:'Enter a SAL'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt:'Enter a COMM'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-combobox" id="deptno" name="deptno"  label="부서번호" style="width:250px" labelPosition="top" 
				data-options="prompt:'Enter a DEPTNO'
					,valueField: 'DEPTNO'
        			,textField: 'DNAME'
        			,url: './jsonDeptList.jsp'
        			,onSelect: function(rec){
        			}"
        		>
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt:'Enter a ZIPCODE'" style="width:100px">
				<a id="btn_zipcode" href="#" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소" data-options="prompt:'Enter a ADDRESS'" style="width:400px">
			</div>
		</form>
		<div id="d_upd" style="margin-bottom:10px">
			<a id="btn_save" href="javascript:emp_upd()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<a id="btn_close" href="javascript:$('#dlg_upd').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
		</form>
	</div>
	
	<!-- ========================================================사원 수정============================================================= -->
	<!-- ========================================================사원 삭제============================================================= -->
	<div id="dlg_del" class="easyui-dialog" data-options="closed:true" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_del">
		
		</form>
	</div>
	
	<!-- ========================================================사원 삭제============================================================= -->
	
</body>
</html>