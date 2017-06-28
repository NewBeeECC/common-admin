<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">用户管理</h3>
				<div class="box-tools pull-right">
					<@shiro.hasPermission name="admin:insert">
						<a onclick="securityToListAjax();" class="btn btn-sm btn-primary" target="modal" modal="lg" href="/user/add">添加</a>
					</@shiro.hasPermission>
				</div>
			</div>
			<div class="box-body">
				<div class="clearfix">
					<div class="col-md-4">
						<div class="input-group date ">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right" id="securityTime" placeholder="选择时间...">
						</div>
					</div>
					<div class="col-md-4">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-search"></i></span>
							<input type="text" class="form-control" id="securityPremise" placeholder="根据账号搜索...">
						</div>
					</div>
					<div class="col-md-4">
						<button type="submit" onclick="securityReload();" class="btn btn-primary">搜索</button>
					</div>
				</div>
				<table id="security_tab" class="table table-bordered table-striped">
					<thead>
						<tr>
							<tr>
								<th>序号</th>
								<th>账号</th>
								<th>昵称</th>
								<th>角色</th>
								<th>状态</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var security_tab;
$(function() {
	//初始化时间选择器
	$('#securityTime').datepicker({
		language: 'zh-CN',
		format: 'yyyy-mm-dd',
		autoclose: true,
		todayHighlight: true
	});
	//初始化表格
	
	var No=0;
	security_tab=$('#security_tab').DataTable({
		"dom":'itflp',
		"processing":true,
		"searching":false,
		"serverSide":true, //启用服务器端分页
		"bInfo":false,
		"language":{"url":"adminlte/plugins/datatables/language.json"},
		"ajax" : {"url":"/user/page","type":"post"},
		"columns":[ 
		    {"data":null}, 
			{"data":"username"},
			{"data":null},
			{"data":null},
			{"data":null},
			{"data":"createtime"},
			{"data":null} 
			],
		"columnDefs":[
			{
			    targets: 0,
			    data: null,
			    render: function (data) {
			    	No=No+1;
			        return No;
			    }
			},
            {
                targets: 2,
                data: null,
                render: function (data) {
                    var name = data.name;
                    return name;
                }
            },
			{
			    targets: 3,
			    data: null,
			    render: function (data) {
			    	var  listStr = "";
			    	var list = data.role;
					if(list){
                        listStr = list.name;
					}
			    	return listStr;
			    }
			},
			{
			    targets: 4,
			    data: null,
			    render: function (data) {
			    	if(data.status == 0){
			    		return "不可用";
			    	}
			    	if(data.status == 1){
			    		return "可用";
			    	}
			    	return "未知状态";
			    }
			},
            {
				"targets" : -1,
				"data" : null,
				"render" : function(data) {
//					debugger;
					var btn = "";
					btn = '<a class="btn btn-xs btn-primary" target="modal" modal="lg" href="/user/view/'+ data.id+ '">查看</a> &nbsp;';
					if(isNull(data.role) ||  'super' != data.role.value){
                        btn +='<@shiro.hasPermission name="admin:update">'
                        +'<a class="btn btn-xs btn-info" onclick="securityToListAjax();" target="modal" modal="lg" href="/user/edit/'+ data.id+ '">修改</a> &nbsp;'
                        +'</@shiro.hasPermission>'
                        +'<@shiro.hasPermission name="admin:delete">'
                        +'<a class="btn btn-xs btn-default" callback="securityReload();" data-body="确认要删除吗？" target="ajaxTodo" href="/user/delete/'+ data.id + '">删除</a>'
                        +'</@shiro.hasPermission>';
					}
					return btn;
			}
		} ]
	}).on('preXhr.dt', function ( e, settings, data ) {
		No=0;
    } );
	
	$("#securitySeek").on("click",function(){
 		reloadTable(security_tab,"#securityTime","#securityPremise");
	});
});

function securityReload(){
	reloadTable(security_tab,"#securityTime","#securityPremise");
}

function securityToListAjax(){
	list_ajax = security_tab;
	console.log(list_ajax);
}
function isNull(data){
    return (data == "" || data == undefined || data == null) ? true : false;
}
</script>