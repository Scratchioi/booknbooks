from rest_framework import serializers
from .models import *

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model= Book
        fields='__all__'

class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model=CustomUser
        fields='_all__'


