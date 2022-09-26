from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        # fields = ['username', 'password', 'email', 'phone']
        fields = '__all__'
        extra_kwargs = {
            'password': {'write_only': True}
        }
    
    def create(self, validated_data):
        password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance

    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.email = validated_data.get('email', instance.email)
        instance.phone = validated_data.get('phone', instance.phone)
        instance.avatar = validated_data.get('avatar', instance.avatar)
        instance.address = validated_data.get('address', instance.address)
        instance.date_of_birth = validated_data.get('date_of_birth', instance.date_of_birth)
        instance.save()
        return instance