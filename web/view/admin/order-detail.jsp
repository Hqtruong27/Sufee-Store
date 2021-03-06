<%-- 
    Document   : customer-list
    Created on : Jul 7, 2020, 10:44:58 AM
    Author     : ASUS
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <div class="card-body">
                            <div id="rows_${orders.orderId}">
                                <strong>Chi tiết đơn hàng #${orders.orderId}</strong>
                                <span>-</span>
                                <c:if test="${orders.orderStatus == 0}">
                                    <span style="color: orange">Đang chờ xác nhận <i class="ti-truck"></i></span>
                                </c:if>
                                <c:if test="${orders.orderStatus == 1}">
                                    <span style="color: green">Đã giao hàng <i class="ti-check"></i></span>
                                </c:if>
                                <c:if test="${orders.orderStatus == -1}">
                                    <span>Đã hủy đơn</span>
                                </c:if>
                                <p>Ngày đặt hàng: <fmt:formatDate pattern=" h:mm a dd/MM/yyyy " value="${orders.createDate}"/></p>
                                <p>
                                    <c:if test="${orders.orderStatus == 0}">
                                        <a href="accept-order.htm?orderId=${orders.orderId}" class="btn btn-success btn-sm" style="color: #ffffff" ><i class="ti-truck"></i> Giao hàng </a>
                                    </c:if>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="col-md-6" style="border-right: 1px solid">
                                <table>
                                    <tbody>
                                    <p>Thông tin khách hàng</p>
                                    <tr>
                                        <td>Người nhận:</td>
                                        <td><strong style="text-transform: capitalize">${orders.fullName}</strong></td>
                                    </tr>
                                    <tr>
                                        <td>Địa chỉ:</td>
                                        <td>${orders.orderAddress}</td>
                                    </tr>
                                    <tr>
                                        <td>Email:</td>
                                        <td>${orders.email}</td>
                                    </tr>
                                    <tr>
                                        <td>Điện thoại:</td>
                                        <td>${orders.phone}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table>
                                    <tbody>
                                    <p>Ghi chú</p>
                                    <tr>
                                        <td>${orders.orderNote}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover ">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Giảm giá</th>
                                            <th style="text-align: right">Tạm tính</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listOrderDetails}" var="od">
                                            <tr>
                                                <td style="line-height: 25px;padding: 20px 15px;">
                                                    <div style="display: flex">
                                                        <c:forEach items="${products}" var="product">
                                                            <c:if test="${product.productId == od.products.productId}">
                                                                <img src="${product.featureImage}" style="width: 60px;height: 60px;margin-right: 5px;"/>
                                                                <div style="display: block">
                                                                    <b>${product.productName}</b>
                                                                    <c:forEach items="${brands}" var="brand">
                                                                        <c:if test="${brand.brandId == product.brands.brandId}">
                                                                            <p style="font-size: 11px">Hãng sản xuất: ${brand.brandName}</p>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:forEach items="${products}" var="product">
                                                        <c:if test="${product.productId == od.products.productId}">
                                                            <fmt:formatNumber value="${product.price}"/> ₫
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${od.orderDetailQuantity}</td>
                                                <td>
                                                    <c:forEach items="${products}" var="product">
                                                        <c:if test="${product.productId == od.products.productId}">
                                                            ${od.products.price*od.products.productSale/100*od.orderDetailQuantity} ₫
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td style="text-align: right"> <fmt:formatNumber value="${od.orderDetailPrice*od.orderDetailQuantity}" /> ₫</td> 
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                    <tfoot style="text-align: right;border: none">
                                        <tr>
                                            <td colspan="4" >
                                                <span>Tổng cộng</span>
                                            </td>
                                            <td>
                                                <span style="color: rgb(255, 59, 39);font-size: 18px;">
                                                    <fmt:formatNumber value="${orders.orderTotalAmount}"/> ₫
                                                </span>

                                            </td>
                                        </tr>

                                    </tfoot>
                                </table>
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
                <button type="button" class="btn btn-primary">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="widget/footer.jsp" flush="true"/>
