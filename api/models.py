from email.policy import default
from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
# TODO: coupon model
class User(AbstractUser):
    name = models.CharField(max_length=255, null=True, blank=True)
    email = models.CharField(max_length=255, unique=True)
    username = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    phone = models.CharField(max_length=15)
    avatar = models.TextField(null=True, blank=True)
    address = models.TextField(null=True, blank=True)
    date_of_birth = models.DateField(null=True, blank=True)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['password', 'email', 'phone']

class Category(models.Model):
    _created = models.CharField(max_length=255, null=True, blank=True)
    _creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='category_creator')
    _updated = models.CharField(max_length=255, null=True, blank=True)
    _updater = models.ForeignKey(User, on_delete=models.CASCADE, related_name="category_updater")
    _deleted = models.CharField(max_length=255, null=True, blank=True)
    name = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)

class Product(models.Model):
    _created = models.CharField(max_length=255, null=True, blank=True)
    _creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='product_creator')
    _updated = models.CharField(max_length=255, null=True, blank=True)
    _updater = models.ForeignKey(User, on_delete=models.CASCADE, related_name="product_updater")
    _deleted = models.CharField(max_length=255, null=True, blank=True)
    name = models.CharField(max_length=255)
    image = models.TextField(null=True, blank=True)
    price = models.FloatField(default=0.0)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='category_fk')
    description = models.TextField(null=True, blank=True)
    quantity = models.IntegerField(default=0)
    PRODUCT_STATUS = [
        ("D", "DISABLE"),
        ("E", "ENABLE"),
    ]
    status = models.CharField(max_length=10, choices=PRODUCT_STATUS, default="E")

class Order(models.Model):
    _created = models.CharField(max_length=255, null=True, blank=True)
    _creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='order_creator')
    _updated = models.CharField(max_length=255, null=True, blank=True)
    _updater = models.ForeignKey(User, on_delete=models.CASCADE, related_name="order_updater")
    _deleted = models.CharField(max_length=255, null=True, blank=True)
    price = models.FloatField(default=0.0)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='order_user_fk')
    PAYMENT_METHOD_ENUM = [
        ("COD", "COD"),
        ("BANKING", "BANKING")
    ]
    ORDER_STATUS_ENUM = [
        ("PENDING", "PENDING"),
        ("DONE", "DONE")
    ]
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHOD_ENUM, default="COD")
    order_status = models.CharField(max_length=10, choices=ORDER_STATUS_ENUM, default="PENDING")

class Review(models.Model):
    _created = models.CharField(max_length=255, null=True, blank=True)
    _creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='review_creator')
    _updated = models.CharField(max_length=255, null=True, blank=True)
    _updater = models.ForeignKey(User, on_delete=models.CASCADE, related_name="review_updater")
    _deleted = models.CharField(max_length=255, null=True, blank=True)
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='review_order_fk')
    content = models.TextField(null=True, blank=True)
    rating = models.FloatField()

class OrderDetail(models.Model):
    _created = models.CharField(max_length=255, null=True, blank=True)
    _creator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='detail_creator')
    _updated = models.CharField(max_length=255, null=True, blank=True)
    _updater = models.ForeignKey(User, on_delete=models.CASCADE, related_name="detail_updater")
    _deleted = models.CharField(max_length=255, null=True, blank=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='order_product_details')
    quantity = models.IntegerField(default=0)
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='detail_order_fk')
    


# class Coupon(models.Model):
#     discount = models.IntegerField(default=0)
#     name = models.CharField(max_length=255)