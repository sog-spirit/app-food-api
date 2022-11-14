from django.urls import path
from .views import (
    RegisterView,
    LoginView,
    UserView,
    LogoutView,
    UpdateUserView,
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
    path('user/register', RegisterView.as_view()),
    path('user/login', LoginView.as_view()),
    path('user/view', UserView.as_view()),
    path('user/logout', LogoutView.as_view()),
    path('user/update', UpdateUserView.as_view()),
    path('product', ProductsAPIView.as_view()),
    path('product/<str:id>', SingleProductAPIView.as_view()),
    path('category', CategoriesAPIView.as_view()),
    path('category/<str:id>', SingleCategoryAPIView.as_view()),
    path('order', OrderAPIView.as_view()),
    path('order/<int:user_id>/detail/<int:order_id>', OrderDetailAPIView.as_view()),
    path('user/<int:user_id>/cart', CartsAPIView.as_view()),
    path('user/<int:user_id>/cart/<int:cart_id>', SingleCartAPIView.as_view()),
    path('user/<int:user_id>/product/<int:product_id>', GetProductOnCartAPIView.as_view()),
]