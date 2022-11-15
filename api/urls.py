from django.urls import path
from django.views.decorators.csrf import csrf_exempt
from .views import (
    RegisterView,
    LoginView,
    UserView,
    LogoutView,
    UpdateUserView,
    UpdatePasswordView,
    ProductsAPIView,
    SingleProductAPIView,
    CategoriesAPIView,
    SingleCategoryAPIView,
    OrderAPIView,
    OrderDetailAPIView,
    CartsAPIView,
    SingleCartAPIView,
    GetProductOnCartAPIView,
)

urlpatterns = [
    path('user/register', csrf_exempt(RegisterView.as_view())),
    path('user/login', csrf_exempt(LoginView.as_view())),
    path('user/view', csrf_exempt(UserView.as_view())),
    path('user/logout', csrf_exempt(LogoutView.as_view())),
    path('user/update', csrf_exempt(UpdateUserView.as_view())),
    path('user/update/password', csrf_exempt(UpdatePasswordView.as_view())),
    path('product', csrf_exempt(ProductsAPIView.as_view())),
    path('product/<str:id>', csrf_exempt(SingleProductAPIView.as_view())),
    path('category', csrf_exempt(CategoriesAPIView.as_view())),
    path('category/<str:id>', csrf_exempt(SingleCategoryAPIView.as_view())),
    path('order', csrf_exempt(OrderAPIView.as_view())),
    path('order/<int:order_id>', csrf_exempt(OrderDetailAPIView.as_view())),
    path('cart', csrf_exempt(CartsAPIView.as_view())),
    path('cart/<int:cart_id>', csrf_exempt(SingleCartAPIView.as_view())),
    path('cart/product/<int:product_id>', csrf_exempt(GetProductOnCartAPIView.as_view())),
]