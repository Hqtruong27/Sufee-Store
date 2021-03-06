<%-- 
    Document   : customer-list
    Created on : Jul 7, 2020, 10:44:58 AM
    Author     : ASUS
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="widget/header.jsp" flush="true"/>
<jsp:include page="widget/navbar.jsp" flush="true"/>
<div id="right-panel" class="right-panel">
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
                            <strong class="card-title">Danh mục phản hồi</strong>
                        </div>
                        <div class="card-body">
                            <table id="myTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Tên danh mục phản hồi</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listFeebackCatalog}" var="listfb">
                                        <tr id="rows_${listfb.feedbackCatalogId}">
                                            <td>${listfb.feedbackCatalogName}</td>
                                            <td>
                                                <c:if test="${listfb.feedbackCatalogStatus == 1}">
                                                    <p class="badge badge-pill badge-success" style="padding: 4px 9px 5px 9px;" data-toggle="tooltip" data-placement="top" title="enable">Kích hoạt</p>
                                                </c:if>
                                                <c:if test="${listfb.feedbackCatalogStatus == 0}">
                                                    <p class="badge badge-pill badge-secondary" style="padding: 4px 9px 5px 9px;" data-toggle="tooltip" data-placement="top" title="disable">Tạm ẩn</p>
                                                </c:if>
                                            </td>
                                            <td style="text-align: center">
                                                <a class="mr-3 btn-change-status" data-status="${listfb.feedbackCatalogStatus}" data-id="${listfb.feedbackCatalogId}" href="#" data-toggle="tooltip" data-placement="bottom" title="Thay đổi trạng thái"><span class=" ti-wand"></span></a>
                                                <a class="mr-3 btn-delete-f" data-id="${listfb.feedbackCatalogId}" href="#" data-toggle="tooltip" data-placement="bottom" title="Xoá"><span class=" ti-trash"></span></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <hr>
                            <strong class="card-title mb-3">Thêm mới danh mục phản hồi</strong>
                            <div class="card-body card-block">
                                <form action="feedback-catalog.htm" method="POST" class="form-horizontal">    
                                    <div class="row form-group">
                                        <div class="col col-md-3"><label for="feedbackCatalogName" class=" form-control-label" >Tên danh mục phản hồi</label></div>
                                        <div class="col-12 col-md-9">
                                            <input type="text" id="feedbackCatalogName" name="feedbackCatalogName" class="form-control" required="Điền vào đây"/>
                                            <small class="form-text text-muted">Tên danh mục phản hồi</small>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-3"><label for="select" class=" form-control-label">Trạng thái</label></div>
                                        <div class="col-12 col-md-9">
                                            <select name="feedbackCatalogStatus" id="feedbackCatalogStatus" class="form-control" required="Điền vào đây">
                                                <option value="">Vui lòng chọn</option>
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Không kích hoạt</option>
                                            </select>
                                            <small class="form-text text-muted">Trạng thái danh mục</small>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col col-md-3"></div>
                                        <div class="col col-md-9">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="ti-check"></i> Xác nhận
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- .animated -->
    </div><!-- .content -->
</div><!-- /#right-panel -->

<!-- Right Panel -->
<div class="modal fade" id="staticModal" tabindex="-1" role="dialog" aria-labelledby="staticModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticModalLabel">Thông báo</h5>
            </div>
            <div class="modal-body">
                <p>
                    Bạn có muốn xóa không ?
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Không</button>
                <button type="button" id="confirmdelete" class="btn btn-primary">Xác nhận</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="widget/footer.jsp" flush="true"/>
<script src="${pageContext.request.contextPath}/view/admin/assets/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="${pageContext.request.contextPath}/view/admin/assets/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="${pageContext.request.contextPath}/view/admin/assets/vendors/datatables.net-buttons/js/buttons.colVis.min.js"></script>
<script src="${pageContext.request.contextPath}/view/admin/assets/bootstrap-notify-3.1.3/notify.min.js" type="text/javascript"></script>
<c:if test="${not empty error}">
    <script>
        (function ($) {
            $('.notifyjs-corner').empty();
            $.notify('${error}', {
                globalPosition: "top center",
                className: 'error'
            });
        })(jQuery);
    </script>
</c:if>
<c:if test="${not empty success}">
    <script>
        (function ($) {
            $('.notifyjs-corner').empty();
            $.notify('${success}', {
                globalPosition: "top center",
                className: 'success'
            });
        })(jQuery);
    </script>
</c:if>

<script>
    (function ($) {
        $("#myTable").DataTable({
            "oLanguage": {
                "oPaginate": {
                    "sPrevious": "Trang trước",
                    "sNext": "Trang sau",
                    "sLast": "Trang cuối",
                    "sFirst": "Trang đầu"
                },
                //searcz
                "sSearch": "Tìm kiếm:",
                "sLengthMenu": "Hiện thị _MENU_ số hàng",
                "sInfo": "Trang _START_ tổng _TOTAL_ (_START_ to _END_)",
                "sInfoEmpty": 'Không có gì để hiển thị',
                "sEmptyTable": "Không có dữ liệu, click vào <span style='font-weight:700'>Thêm mới</span> để thêm dữ liệu"
            },
            "order": [[1, "asc"]]
        });
        //
        $(".btn-change-status").off("click").on("click", function (e) {
            e.preventDefault();
            var id = $(this).data("id");
            $.ajax({
                type: 'GET',
                url: "change-statusfeedbackcatalog.htm",
                data: {feedbackCatalogId: id},
                success: function (res) {
                    if (res === "1") {
                        $("#rows_" + id + " td p").text("Kích hoạt");
                        $("#rows_" + id + " td p").removeClass();
                        $("#rows_" + id + " td p").addClass("badge badge-pill badge-success");
                        $('.notifyjs-corner').empty();
                        $.notify('Thay đổi trạng thái thành công !', {
                            globalPosition: "top center",
                            className: 'success'
                        });
                    } else if (res === "0") {
                        $("#rows_" + id + " td a").remove("data-status");
                        $("#rows_" + id + " td p").text("Tạm ẩn");
                        $("#rows_" + id + " td p").removeClass();
                        $("#rows_" + id + " td p").addClass("badge badge-pill badge-secondary");
                        $('.notifyjs-corner').empty();
                        $.notify('Thay đổi trạng thái thành công !', {
                            globalPosition: "top center",
                            className: 'success'
                        });
                    } else {
                        $('.notifyjs-corner').empty();
                        $.notify('Có gì đó không đúng !', {
                            globalPosition: "top center",
                            className: 'error'
                        });
                    }
                    $("#ModalLock").modal('hide');
                }
            });
        });
        //delete f catalog
        var id;
        $(".btn-delete-f").on("click", function (e) {
            e.preventDefault();
            id = $(this).data("id");
            $("#staticModal").modal('show');
        });
        $("#confirmdelete").on("click", function (e) {
            e.preventDefault();
            $.ajax({
                type: 'GET',
                url: "delete-feedback-catalog.htm",
                data: {feedbackCatalogId: id},
                success: function (res) {
                    if (res == "success") {
                        $("#staticModal").modal('hide');
                        $("#rows_" + id + "").remove();
                        $.notify({
                            title: '<strong>Success: </strong>',
                            message: 'Xoá thành công'
                        }, {
                            type: 'success',
                            allow_dismiss: false
                        });
                    } else {
                        $.notify({
                            title: '<strong>Error: </strong>',
                            message: 'Không đúng'
                        }, {
                            type: 'danger',
                            allow_dismiss: false
                        });
                    }
                }
            });
        });
    })(jQuery);
</script>