﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="top.jsp"/>
<%@page import="com.tt.oa.global.Content" %>
<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 待处理报销单 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel  heading-border">
                <div class="panel-menu">
                    <div class="row">
                        <div class="hidden-xs hidden-sm col-md-3">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default light">
                                    <i class="fa fa-refresh"></i>
                                </button>
                                <button type="button" class="btn btn-default light">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-9 text-right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default light">
                                    <i class="fa fa-chevron-left"></i>
                                </button>
                                <button type="button" class="btn btn-default light">
                                    <i class="fa fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body pn">
                    <table id="message-table" class="table admin-form theme-warning tc-checkbox-1">
                        <thead>
                        <tr class="">
                            <th class="text-center hidden-xs">Select</th>
                            <th class="hidden-xs">事由</th>
                            <th>状态</th>
                            <th class="hidden-xs">创建人</th>
                            <th class="hidden-xs">金额</th>
                            <th class="text-center">创建时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${toDealReceipts}" var="toDealReceipt">
                                <tr class="message-unread">
                                    <td class="hidden-xs">
                                        <label class="option block mn">
                                            <input type="checkbox" name="mobileos" value="FR">
                                            <span class="checkbox mn"></span>
                                        </label>
                                    </td>
                                    <td>${toDealReceipt.cause}</td>
                                    <td class="hidden-xs">
                                        <span class="badge badge-warning mr10 fs11"> ${toDealReceipt.state} </span>
                                    </td>
                                    <td> ${toDealReceipt.createPersonId}</td>
                                    <td class="text-center fw600">${toDealReceipt.totalMoney}</td>
                                    <td><spring:eval expression="toDealReceipt.createTime"/></td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${toDealReceipt.state == Content.CLAIMVOUCHER_CREATED || toDealReceipt.state == Content.CLAIMVOUCHER_BACK}">
                                                <a href="/receipts/to_update?id=${toDealReceipt.id}">修改</a>
                                                <a href="/receipts/submit?id=${toDealReceipt.id}">提交</a>
                                            </c:when>
                                            <c:when test="${toDealReceipt.state == Content.CLAIMVOUCHER_SUBMIT || toDealReceipt.state == Content.CLAIMVOUCHER_RECHECK}">
                                                <a href="/receipts/tocheck?id=${toDealReceipt.id}">审核</a>
                                            </c:when>
                                            <c:when test="${toDealReceipt.state == Content.CLAIMVOUCHER_APPROVED}">
                                                <a href="/receipts/tocheck?id=${toDealReceipt.id}">打款</a>
                                            </c:when>
                                        </c:choose>
                                        <a href="/receipts/detail?receiptsId=${toDealReceipt.id}">详细信息</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="bottom.jsp"/>

