from rest_framework import serializers
from .models import *

class book(serializers.ModelSerializer):
    class Meta:
        model= Book
        fields='__all__'

class CustomUser(serializers.ModelSerializer):
    class Meta:
        model=CustomUser
        fields='_all__'


