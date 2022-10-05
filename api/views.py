from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from rest_framework import status
from .serializers import UserSerializer, ProductSerializer, CategorySerializer
from .models import User, Product, Category
import jwt
from datetime import datetime

# Create your views here.
class RegisterView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

class LoginView(APIView):
    def post(self, request):
        username = request.data['username']
        password = request.data['password']

        user = User.objects.filter(username=username).first()

        if user is None:
            raise AuthenticationFailed('User not found')
        
        if not user.check_password(password):
            raise AuthenticationFailed('Incorrect password')
        
        payload = {
            'id': user.id,
            'exp': datetime.utcnow() + datetime.timedelta(minutes=60),
            'iat': datetime.utcnow()
        }
        if user.is_superuser:
            user_role = 'Admin'
        elif user.is_staff:
            user_role = 'Staff'
        else:
            user_role = 'Customer'
        
        token = jwt.encode(payload, 'secret', algorithm='HS256')
        response = Response()
        response.set_cookie(key='jwt', value=token, httponly=True)
        response.data = {
            'jwt': token,
            'role': user_role
        }

        return response

class UpdateUserView(APIView):
    def patch(self, request):
        token = request.COOKIES.get('jwt')

        if not token:
            raise AuthenticationFailed('User is not authenticated')
        
        try:
            payload = jwt.decode(token, 'secret', algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            raise AuthenticationFailed('JWT token expired')
        
        user = User.objects.filter(id=payload['id']).first()
        serializer = UserSerializer(user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        response = Response()
        response.data = {
            'message': 'User info updated successfully'
        }
        return response

class UserView(APIView):
    def get(self, request):
        token = request.COOKIES.get('jwt')

        if not token:
            raise AuthenticationFailed('User is not authenticated')
        
        try:
            payload = jwt.decode(token, 'secret', algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            raise AuthenticationFailed('JWT token expired')
        
        user = User.objects.filter(id=payload['id']).first()
        serializer = UserSerializer(user)

        return Response(serializer.data)

class LogoutView(APIView):
    def post(self, request):
        response = Response()
        response.delete_cookie('jwt')
        response.data = {
            'message': 'Logout successfully'
        }
        return response

class ProductsAPIView(APIView):
    def get(self, request):
        products = Product.objects.all().filter(_deleted=None)
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)

    def post(self, request):
        data = request.data
        serializer = ProductSerializer(data=data)

        if serializer.is_valid():
            serializer.save()

            return Response(serializer.data, status=status.HTTP_201_CREATED)
            
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SingleProductAPIView(APIView):
    def get(self, request, id):
        product = Product.objects.get(id=id)
        serializer = ProductSerializer(product, many=False)

        if product._deleted == None:
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)

        return Response(None, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request, id):
        data = request.data
        product = Product.objects.get(id=id)
        serializer = ProductSerializer(instance=product, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        product = Product.objects.get(id=id)
        serializer = ProductSerializer(instance=product, data={ "_deleted": datetime.now() }, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CategoriesAPIView(APIView):
    def get(self, request):
        categories = Category.objects.all().filter(_deleted=None)
        serializer = CategorySerializer(categories, many=True)
        return Response(serializer.data)
    
    def post(self, request):
        data = request.data
        serializer = CategorySerializer(data=data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SingleCategoryAPIView(APIView):
    def get(self, request, id):
        data = request.data
        category = Category.objects.get(id=id)
        serializer = CategorySerializer(category, many=False)

        if category._deleted == None:
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(None, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, id):
        data = request.data
        category = Category.objects.get(id=id)
        serializer = CategorySerializer(instance=category, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def delete(self, request, id):
        category = Category.objects.get(id=id)
        serializer = CategorySerializer(instance=category, data={'_deleted': datetime.now() }, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)