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
]