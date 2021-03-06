<%@page import="com.bryantchang.autodepsys.bean.Cluster"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.bryantchang.autodepsys.bean.User"%>
<%@ page import="com.bryantchang.autodepsys.constant.Constants" %>
<%@ page import="java.util.HashMap" %>
<%
	ArrayList<Cluster> list = (ArrayList<Cluster>) request.getAttribute("clusterlist");
	String baseUrl = Constants.BaseUrl;
    HashMap<Long, String> clusterMap = (HashMap<Long, String>) request.getAttribute("clusterinfomap");
%>



<jsp:include page="../nav.jsp" />
<div class="row-fluid">
	<div class="span2">
		<a id="modal-694172" href="#addCluster" role="button"
		   class="btn btn-primary btn-block" data-toggle="modal">添加集群</a>
		<div id="addCluster" class="modal hide fade" role="dialog"
			 aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				<h3 id="myModalLabel">添加集群</h3>
			</div>
			<div class="modal-body">
				<div class="alert alert-info">
					增加集群，需要用户填写，集群的名称以及描述。
				</div>
				<form class="form-horizontal">
					<div class="control-group">
						<label class="control-label" for="clustername">集群名称</label>
						<div class="controls">
							<input type="text" id="clustername" placeholder="集群名称">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="cdesc">集群描述</label>
						<div class="controls">
							<input type="text" id="cdesc" placeholder="集群描述">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="infoid">集群类型</label>
						<div class="controls">
							<select id="infoid" class="form-control">
								<c:forEach items="${clusterinfomap}" var="info">
									<option value="${info.key}">${info.value}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
				<button id="submitAddCluster" class="btn btn-primary">添加</button>
			</div>
		</div>
	</div>

    <div class="span10">
        <c:if test="${list.size() != 0}">
            <h3 align="center">我的集群列表</h3>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>集群名称</th>
                    <th>集群描述</th>
                    <th>集群类型</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${clusterlist}" var="cluster" varStatus="no">
                        <tr>
                            <td>${no.count}</td>
                            <td>${cluster.cname}</td>
                            <td>${cluster.cdesc}</td>
                            <td>${clusterinfomap[cluster.infoid]}</td>
							<td>${cluster.ctime}</td>
							<td>
								<div class="btn-group">
									<a class="btn" href="#update_cluster_${cluster.id}"
									   data-toggle="modal"><i class="icon-wrench"></i> 修改节点</a> <a
										class="btn btn-danger"
										href="#delete_cluster_${cluster.id}"
										data-toggle="modal"><i class="icon-remove"></i> 删除节点</a>
								</div>
							</td>
                        </tr>
                    </c:forEach>
                </tbody>
			</table>

			<c:forEach items="${clusterlist}" var="cluster"
					   varStatus="no">
				<div id="update_cluster_${cluster.id}"
					 class="modal hide fade" tabindex="-1" role="dialog"
					 aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">×</button>
						<h3 id="myModalLabel">修改节点</h3>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="control-group">
								<label class="control-label" for="cname_${cluster.id}">集群名称</label>
								<div class="controls">
									<input type="text" id="cname_${cluster.id}" placeholder="集群名称"
										   value="${cluster.cname}">
								</div>
							</div>
							<div class="control-group">id
								<label class="control-label" for="cdesc_${cluster.id}">集群描述</label>
								<div class="controls">
									<input type="text" id="cdesc_${cluster.id}" placeholder="集群描述"
										   value="${cluster.cdesc}">
								</div>
							</div>

                            <div class="control-group">
								<label class="control-label" for="desc_${cluster.id}">集群类型</label>
								<div class="controls">
									<select id="infoid_${cluster.id}" class="form-control">
										<c:forEach items="${clusterinfomap}" var="info">
											<c:choose>
												<c:when test="${cluster.infoid == info.key}">
													<option value="${info.key}" selected="selected">${info.value}</option>
												</c:when>
												<c:otherwise>
													<option value="${info.key}">${info.value}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
                            </div>

							<input type="hidden" id="curCluster" value="${cluster.id}"/>
							<input type="hidden" id="curUser" value="${userid}"/>
						</form>
					</div>
					<div class="modal-footer">
						<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
						<button update="${cluster.id}" class="btn btn-primary submitUpdateCluster">保存</button>
					</div>
				</div>
			</c:forEach>

        </c:if>
    </div>
</div>

</div>
</html>




