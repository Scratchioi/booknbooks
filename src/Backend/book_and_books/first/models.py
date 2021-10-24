from django.db import models
from django.contrib.auth.base_user import BaseUserManager
from django.db.models.base import Model
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import AbstractUser




class CustomUserManager(BaseUserManager):
    """
    Custom user model manager where email is the unique identifiers
    for authentication instead of usernames.
    """
    def create_user(self, email, password,**extra_fields):
        """
        Create and save a User with the given email and password.
        """
        if not email:
            raise ValueError(_('The Email must be set'))
        email = self.normalize_email(email)
        user = self.model(email=email ,**extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, email, password, **extra_fields):
        """
        Create and save a SuperUser with the given email and password.
        """
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)
       

        if extra_fields.get('is_staff') is not True:
            raise ValueError(_('Superuser must have is_staff=True.'))
        if extra_fields.get('is_superuser') is not True:
            raise ValueError(_('Superuser must have is_superuser=True.'))
        return self.create_user(email, password,username, **extra_fields)



class Book(models.Model):
    Author=models.CharField(max_length=100)
    description = models.TextField()
    genre=models.TextField()
    img_link= models.URLField(blank=True, null=True)
    isbn=models.BigIntegerField(unique=True)
    rating=models.FloatField(default=0)
    pages=models.IntegerField(default=0)
    title=models.TextField(blank=True,null=True)
    get=models.URLField(blank=True,null=True)
    cloudflare=models.URLField(blank=True,null=True)
    ipes=models.URLField(blank=True,null=True)
    infura=models.URLField(blank=True,null=True)

    def __str__(self):
        return self.title






class CustomUser(AbstractUser):
    username=None
    email = models.EmailField(_('email address'), unique=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    

    def __str__(self):

        return self.email
class User_features(models.Model):
    user=models.ForeignKey(CustomUser,on_delete=models.CASCADE,blank=False)
    name=models.CharField(blank=False,max_length=100)
    username=models.CharField(unique=True,max_length=100)
    dob=models.DateField(blank=False)
    intrest=models.TextField()



    
