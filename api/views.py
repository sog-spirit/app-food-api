from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed, ParseError
from rest_framework import status
from .serializers import (
    UserSerializer,
    ProductSerializer,
    CategorySerializer,
    OrderDetailSerializer,
    CartSerializer,
)
from django.db import IntegrityError, transaction
from .models import (
    User,
    Product,
    Category,
    History,
    Order,
    OrderDetail,
    Cart,
)
import jwt
from datetime import datetime, timedelta
from .helper import user_authentication, user_permission_authentication

class RegisterView(APIView):
    """
    Required fields:
    email
    username
    password
    phone
    """
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = User.objects.create_user(
            email=request.data['email'],
            username=request.data['username'],
            password=request.data['password'],
            phone=request.data['phone'],
        )
        History.objects.create(
            _creator = user,
            message = "create new user",
        )
        return Response(
            {
                'detail': 'User created successfully',
            },
            status=status.HTTP_201_CREATED
        )

class LoginView(APIView):
    """
    Required fields:
    username
    password
    """
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
            'exp': datetime.utcnow() + timedelta(minutes=60),
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
        response.set_cookie(key='jwt', value=token)
        response.data = {
            'jwt': token,
            'detail': 'Login successfully'
        }
        History.objects.create(
            _creator = user,
            message = "was login",
        )
        return response

class UpdateUserView(APIView):
    """
    Any fields defined in User class from models.py
    """
    def patch(self, request):
        payload = user_authentication(request)
        user = User.objects.filter(id=payload['id']).first()
        serializer = UserSerializer(user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        History.objects.create(
            _creator = user,
            message = "update user",
        )
        return Response(
            {
                'detail': 'User info updated successfully'
            }
        )

class UserView(APIView):
    def get(self, request):
        payload = user_authentication(request)
        user = User.objects.filter(id=payload['id']).first()
        serializer = UserSerializer(user)

        return Response(serializer.data)

class LogoutView(APIView):
    def post(self, request):
        response = Response()
        response.delete_cookie('jwt')
        response.data = {
            'detail': 'Logout successfully'
        }

        return response

class ProductsAPIView(APIView):
    def get(self, request):
        products = Product.objects.all().filter(_deleted=None)
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)

    """
    Required:
    category
    _creator (auto created with user id)
    _updater (auto created with user id)
    """
    def post(self, request):
        payload = user_permission_authentication(request)
        data = request.data.copy()
        data['_creator'] = payload['id']
        data['_updater'] = payload['id']
        serializer = ProductSerializer(data=data)

        if serializer.is_valid():
            serializer.save()
            user = User.objects.filter(id=payload['id']).first()
            History.objects.create(
                _creator = user,
                message = "create new product",
            )
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
        payload = user_permission_authentication(request)
        data = request.data.copy()
        data['_updater'] = payload['id']
        product = Product.objects.get(id=id)
        if product._deleted is not None:
            return Response({
                'detail': 'Product is already deleted'
            },
            status=status.HTTP_400_BAD_REQUEST)
        
        serializer = ProductSerializer(instance=product, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            user = User.objects.filter(id=payload['id']).first()
            History.objects.create(
                _creator = user,
                message = "update product",
            )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        payload = user_permission_authentication(request)
        product = Product.objects.get(id=id)
        if product._deleted is not None:
            return Response({
                'detail': 'Product is already deleted'
            },
            status=status.HTTP_400_BAD_REQUEST)

        serializer = ProductSerializer(
            instance=product,
            data={
                "_deleted": datetime.now(),
                '_updater': payload['id']
            },
            partial=True
        )

        if serializer.is_valid():
            serializer.save()
            user = User.objects.filter(id=payload['id']).first()
            History.objects.create(
                _creator = user,
                message = "delete product",
            )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CategoriesAPIView(APIView):
    def get(self, request):
        categories = Category.objects.all().filter(_deleted=None)
        serializer = CategorySerializer(categories, many=True)
        return Response(serializer.data)
    
    """
    Required fields:
    name
    _creator (auto created with user id)
    _updater (auto created with user id)
    """
    def post(self, request):
        payload = user_permission_authentication(request)
        data = request.data.copy()
        data['_creator'] = payload['id']
        data['_updater'] = payload['id']
        serializer = CategorySerializer(data=data)

        if serializer.is_valid():
            serializer.save()
            user = User.objects.filter(id=payload['id']).first()
            History.objects.create(
                _creator = user,
                message = "create new category",
            )
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
        payload = user_permission_authentication(request)
        data = request.data
        data['_updater'] = payload['id']
        category = Category.objects.get(id=id)
        if category._deleted is not None:
            return Response({
                'detail': 'Category is already deleted'
            },
            status=status.HTTP_400_BAD_REQUEST)
        serializer = CategorySerializer(instance=category, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            user = User.objects.filter(id=payload['id']).first()
            History.objects.create(
                _creator = user,
                message = "update category",
            )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def delete(self, request, id):
        payload = user_permission_authentication(request)
        category = Category.objects.get(id=id)
        if category._deleted is not None:
            return Response({
                'detail': 'Category is already deleted'
            },
            status=status.HTTP_400_BAD_REQUEST)
        
        serializer = CategorySerializer(
            instance=category,
            data={
                '_deleted': datetime.now(),
                '_updater': payload['id']
            },
            partial=True)

        if serializer.is_valid():
            serializer.save()
            user = User.objects.filter(id=payload['id']).first()
            History.objects.create(
                _creator = user,
                message = "delete category",
            )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class OrderAPIView(APIView):
    def post(self, request):
        payload = user_authentication(request)
        user = User.objects.filter(id=payload['id']).first()
        price = 0.0

        for item in request.data['data']:
            print(item)
        
        try:
            with transaction.atomic():
                order = Order.objects.create(
                    _creator = user,
                    _updater = user,
                    user = user
                )

                History.objects.create(
                    _creator = user,
                    message = "create order",
                )

                for item in request.data['data']:
                    product = Product.objects.filter(id=item['product']).first()
                    data = item.copy()
                    data['_creator'] = payload['id']
                    data['_updater'] = payload['id']
                    data['order'] = order.id

                    cart_item = Cart.objects.filter(
                        product=product,
                        _creator=user,
                        _deleted=None
                        ).first()
                    cart_item._deleted = datetime.now()
                    cart_item._updater = user
                    cart_item.save()

                    serializer = OrderDetailSerializer(data=data)

                    if serializer.is_valid(raise_exception=True):
                        serializer.save()
                        History.objects.create(
                            _creator = user,
                            message = "create order detail"
                        )
                        price += product.price * item['quantity']
                        continue
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                
                order.price = price
                order.save()

        except IntegrityError:
            return Response({'detail': 'Query error'},status=status.HTTP_400_BAD_REQUEST)

        except KeyError:
            return Response({'detail': 'Missing parameters'}, status=status.HTTP_400_BAD_REQUEST)
        
        return Response(request.data)

class CartsAPIView(APIView):
    def get(self, request, user_id):
        cart_items = Cart.objects.filter(_deleted=None, _creator=user_id)
        serializer = CartSerializer(cart_items, many=True)
        return Response(serializer.data)

    def post(self, request, user_id):
        # payload = user_authentication(request)
        # if user_id != payload['id']:
        #     return Response({'detail': 'Permission denied'}, status=status.HTTP_400_BAD_REQUEST)
        
        data = request.data.copy()
        data['_creator'] = user_id
        data['_updater'] = user_id
        user = User.objects.filter(id=user_id).first()

        try:
            with transaction.atomic():
                serializer = CartSerializer(data=data)

                if serializer.is_valid():
                    serializer.save()
                    History.objects.create(
                        _creator = user,
                        message = "create cart item"
                    )
                    return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
                
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        except IntegrityError:
            return Response({'detail': 'Error creating cart item'}, status=status.HTTP_400_BAD_REQUEST)

class SingleCartAPIView(APIView):
    def delete(self, request, user_id, cart_id):
        # payload = user_authentication(request)
        # if user_id != payload['id']:
        #     return Response({'detail': 'Permission denied'}, status=status.HTTP_400_BAD_REQUEST)
        
        cart_item = Cart.objects.filter(id=cart_id, _creator=user_id).first()

        if cart_item._deleted is not None:
            return Response({
                'detail': 'Cart item is already deleted'
            },
            status=status.HTTP_400_BAD_REQUEST)

        serializer = CartSerializer(
            instance=cart_item,
            data = {
                '_deleted': datetime.now(),
                '_updater': user_id
                # '_updater': payload['id']
            },
            partial = True
        )

        if serializer.is_valid():
            serializer.save()
            # user = User.objects.filter(id=payload['id']).first()
            # History.objects.create(
            #     _creator = user,
            #     message = "delete cart item"
            # )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, user_id, cart_id):
        # payload = user_authentication(request)
        # if user_id != payload['id']:
        #     return Response({'detail': 'Permission denied'}, status=status.HTTP_400_BAD_REQUEST)
        
        data = request.data.copy()
        cart_item = Cart.objects.get(id=cart_id)
        if cart_item._deleted is not None:
            return Response({
                'detail': 'Cart item is already deleted'
            },
            status = status.HTTP_400_BAD_REQUEST)
        
        serializer = CartSerializer(instance=cart_item, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            # user = User.objects.filter(id=payload['id']).first()
            # History.objects.create(
            #     _creator = user,
            #     message = "Update cart item",
            # )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class GetProductOnCartAPIView(APIView):
    def get(self, request, user_id, product_id):
        try:
            cart_item = Cart.objects.get(product=product_id, _deleted=None, _creator=user_id)
        except Cart.DoesNotExist:
            return Response(
                {},
                status=status.HTTP_200_OK
            )
        serializer = CartSerializer(cart_item)
        return Response(serializer.data)
    
    def put(self, request, user_id, product_id):
        # payload = user_authentication(request)
        # if user_id != payload['id']:
        #     return Response({'detail': 'Permission denied'}, status=status.HTTP_400_BAD_REQUEST)
        
        data = request.data.copy()
        try:
            cart_item = Cart.objects.get(product=product_id, _deleted=None, _creator=user_id)
        except Cart.DoesNotExist:
            return Response(
                {'detail': 'cart item does not exist'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        serializer = CartSerializer(instance=cart_item, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            # user = User.objects.filter(id=payload['id']).first()
            # History.objects.create(
            #     _creator = user,
            #     message = "Update cart item",
            # )
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)