from django.db import models
from django.contrib.auth.base_user import BaseUserManager
from django.db.models.base import Model
from django.db.models.deletion import CASCADE
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
        return self.create_user(email, password, **extra_fields)



class Book(models.Model):
    Author=models.CharField(max_length=100)
    description = models.TextField()
    genre=models.TextField()
    img_link= models.URLField(blank=True, null=True)
    isbn=models.CharField(max_length=100,unique=True)
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
    name=models.CharField(blank=True,max_length=100,null=True)
    # username=models.CharField(unique=True,max_length=100)
    dob=models.DateField(blank=True,null=True)
    intrest=models.TextField(blank=True,null=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    

    def __str__(self):

        return self.email

class user_interaction(models.Model):

    user=models.ForeignKey(CustomUser,on_delete=CASCADE,default=False)
    book=models.ForeignKey(Book,on_delete=CASCADE,default=False)
    read=models.BooleanField(default=False)
    completed=models.BooleanField(default=False)
    page_num=models.IntegerField(default=0)

    def __str__(self):
        return str(self.user) + str(self.book)



    
# class Shelves(models.Model):
#     id=models.AutoField()
#     name=models.CharField(max_length=100,default=None,null=True)
#     user=models.ForeignKey(CustomUser,default=None,null=True,on_delete=CASCADE)
#     books=models.ForeignKey(Book,default=None,null=True,on_delete=CASCADE)



    
