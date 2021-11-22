from rest_framework import serializers
from .models import *



class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model= Book
        fields='__all__'

class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model=CustomUser
        fields='__all__'
class user_interaction_serializer(serializers.ModelSerializer):
    class Meta:
        model=user_interaction
        fields='__all__'


