<%-- 
    Document   : customer-list
    Created on : Jul 7, 2020, 10:44:58 AM
    Author     : ASUS
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="widget/header.jsp" flush="true"/>
<jsp:include page="widget/navbar.jsp" flush="true"/>
<div id="right-panel" class="right-panel" >
    <header id="header" class="header">
        <div class="header-menu">
            <div class="col-sm-7">
                <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                <div class="header-left">
                    <button class="search-trigger"><i class="fa fa-search"></i></button>
                    <div class="form-inline">
                        <form class="search-form">
                            <input class="form-control mr-sm-2" type="text" placeholder="Search ..." aria-label="Search">
                            <button class="search-close" type="submit"><i class="fa fa-close"></i></button>
                        </form>
                    </div>
                    <div class="dropdown for-notification">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="notification" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="ti-shopping-cart"></i>
                            <c:if test="${not empty countNotifyOrder}">
                                <span class="count bg-danger">${countNotifyOrder}</span>
                            </c:if>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="notification">
                            <p class="red">Đơn hàng chưa giao</p>
                            <c:forEach items="${listOrder}" var="notifyOrder">
                                <a class="dropdown-item media bg-flat-color-0" href="<%=request.getContextPath()%>/admin/orders-detail.htm?orderId=${notifyOrder.orderId}">
                                    <span class="message media-body" >
                                        <span class="name float-left">${notifyOrder.email}</span>
                                        <p class="time float-left"><fmt:formatNumber value="${notifyOrder.orderTotalAmount}"/>₫</p>
                                        <p class="time float-left"><fmt:formatDate pattern="dd/MM/yyyy" value="${notifyOrder.createDate}"/></p>
                                    </span>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="dropdown for-message">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="message" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="ti-email" title="Phản hồi khách hàng"></i>
                            <c:if test="${not empty countNotifyFeedback}">
                                <span class="count bg-primary">${countNotifyFeedback}</span>
                            </c:if>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="message">
                            <c:forEach items="${listFeedback}" var="notifyFeedback">
                                <a class="dropdown-item media bg-flat-color-0" href="<%=request.getContextPath()%>/admin/feedback-detail.htm?feedbackId=${notifyFeedback.feedbackId}">
                                    <span class="message media-body" >
                                        <span class="name float-left">${notifyFeedback.fullname}</span>
                                        <p class="time float-left">${notifyFeedback.content}</p>
                                        <p class="time float-left"><fmt:formatDate pattern="dd/MM/yyyy" value="${notifyFeedback.feedbacksTime}"/></p>
                                    </span>
                                </a>
                            </c:forEach>
                            <a href="<%=request.getContextPath()%>/admin/feedback.htm"><button style="width: 100%" type="button" class="btn btn-outline-secondary btn-sm">Xem thêm </button></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-5">
                <c:if test="${not empty InfoAdmin}">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="${pageContext.request.contextPath}/view/admin/uploads/admin.jpg" alt="User Avatar">
                        </a>
                        <div class="user-menu dropdown-menu">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/info-admin.htm"><i class="mr-2 fa fa-user"></i> Thông tin </a>
                            <a class="nav-link" href="logout.htm"><i class="mr-2 fa fa-power-off"></i> Logout</a>
                        </div>
                    </div>
                    <div class="float-right"  style="margin: 7px 14px 0px 0px;"id="">
                        <a href="#">${InfoAdmin.fullname}</a>
                    </div>
                </c:if>
            </div>
        </div>
    </header>
    <div class="breadcrumbs">
        <div class="col-sm-4">
            <div class="page-header float-left">
                <div class="page-title">
                    <h1>Dashboard</h1>
                </div>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="page-header float-right">
                <div class="page-title">
                    <ol class="breadcrumb text-right">
                        <li><a href="#">Dashboard</a></li>
                        <li><a href="#">Table</a></li>
                        <li class="active">Data table</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <div class="content mt-3">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <strong>Cập nhật tin tức</strong> 
                        </div>
                        <div class="card-body card-block">
                            <f:form action="update-news.htm" commandName="new"  method="POST" class="form-horizontal">
                                <f:hidden id="newsId" path="newsId"  class="form-control" />
                                <f:hidden id="countView" path="countView"  class="form-control" />
                                <div class="row form-group">
                                    <div class="col col-md-3"><label for="text-input" class=" form-control-label">Tiêu đề</label></div>
                                    <div class="col-12 col-md-9">
                                        <f:input  id="newTitle" path="newTitle" class="form-control"/>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col col-md-3"><label for="select" class=" form-control-label">Chuyên mục tin</label></div>
                                    <div class="col-12 col-md-9">
                                        <select name="catalogs.catalogId" id="catalogId" class="form-control">
                                            <option value="">Vui lòng chọn</option>       
                                            <c:forEach items="${listCatalog}" var="list">
                                                <option <c:if test="${new.catalogs.catalogId == list.catalogId}">selected</c:if> value="${list.catalogId}">${list.catalogName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col col-md-3"><label for="" class=" form-control-label">Hình ảnh</label></div>
                                    <div class="col-12 col-md-9">
                                        <button id="btn-upload" class="btn btn-secondary " style="display: inline-block;margin-top: -6px">Chọn ảnh</button>
                                        <f:input type="text" id="newImage" readonly="true"  path="newImage" class="form-control" cssStyle="border-left: none; border-radius: 0;margin-left: -4px;max-width: 766px;display: inline-block;"/>
                                         <c:if test="${empty errorimgs}"><small class="form-text text-muted">Hình ảnh tin tức</small></c:if><c:if test="${not empty errorimgs}"><small class="form-text text-danger">${errordescription}</small></c:if>
                                        <div class="show-for-newImage"></div>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col col-md-3"><label for="newDescription" class=" form-control-label">Mô tả ngắn</label></div>
                                    <div class="col-12 col-md-9">
                                        <f:input type="text" id="newDescription"  path="newDescription" class="form-control"/>
                                        <c:if test="${not empty errordescription}"><small class="form-text text-danger">${errordescription}</small></c:if>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-3"><label for="newContent" class=" form-control-label">Nội dung</label></div>
                                        <div class="col-12 col-md-9">
                                        <f:textarea  id="newContent" rows="9" path="newContent" required="required" class="form-control"/>
                                        <c:if test="${not empty errorcontent}"><small class="form-text text-danger">${errorcontent}</small></c:if>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-3"><label for="select" class=" form-control-label">Trạng thái</label></div>
                                        <div class="col-12 col-md-9">
                                            <select name="newStatus" id="newStatus" class="form-control">
                                                <option <c:if test="${new.newStatus == 1}">selected</c:if> value="1">Duyệt bài</option>
                                            <option <c:if test="${new.newStatus == 0}">selected</c:if>  value="0">Chưa duyệt</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-3">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="ti-check"></i> Xác nhận
                                            </button>
                                            <a href="news.htm" class="btn btn-danger btn-sm">
                                                <i class="ti-back-left"></i> Làm lại
                                            </a>
                                        </div>
                                    </div>
                            </f:form>
                        </div>

                    </div>
                </div>
            </div><!-- .animated -->
        </div><!-- .content -->
    </div><!-- /#right-panel -->
</div>

<jsp:include page="widget/footer.jsp" flush="true"/>
<script src="${pageContext.request.contextPath}/view/admin/assets/bootstrap-notify-3.1.3/dist/bootstrap-notify.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/view/admin/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/view/admin/ckfinder/ckfinder.js" type="text/javascript"></script>
<script>CKFinder.setupCKEditor(CKEDITOR.replace('newContent'), '${pageContext.request.contextPath}/view/admin/ckfinder/');</script>
<c:if test="${not empty error}">
    <script>
        (function ($) {
            $.notify({
                title: '<strong>Error: </strong>',
                message: '${error}'
            }, {
                type: 'danger',
                allow_dismiss: false
            });
        })(jQuery);
    </script>
</c:if>
<script>
    (function ($) {
        $("#btn-upload").click(function (event) {
            event.preventDefault();
            var finder = new CKFinder();
            finder.selectActionFunction = function (url) {
                $("#newImage").val(url);
                $(".show-for-newImage").html("<img src='" + url + "' width='60' />");
            };
            finder.popup();
        });
    })(jQuery);
</script>