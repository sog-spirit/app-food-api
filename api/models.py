from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class User(AbstractUser):
    name = models.CharField(max_length=255, null=True)
    email = models.CharField(max_length=255, unique=True)
    username = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    phone = models.CharField(max_length=15)
    avatar = models.TextField(null=True)
    address = models.TextField(null=True)
    date_of_birth = models.DateField(null=True)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['password', 'email', 'phone']