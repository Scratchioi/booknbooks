from django.http.response import HttpResponse
from django.shortcuts import render
from .models import Book,CustomUser
import pandas as pd
from rest_framework import serializers
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.decorators import action, permission_classes
from rest_framework import viewsets,status,generics,views,filters
from .serializer import CustomUserSerializer, BookSerializer


def populating(request):
    data = pd.read_csv(r'C:\Users\offic\Desktop\Minor pRojEKT\data.csv')
    columns=['author', 'desc', 'genre', 'img', 'isbn',
       'pages', 'rating', 'title', 'GET', 'Cloudflare', 'IPFS.io', 'Infura']
       
    for i in range(0,data.shape[0]):
        try:
            instance=Book(Author=data['author'][i],description=data['desc'][i],genre=data['genre'][i],img_link=data['img'][i],isbn=data['isbn'][i],rating=data['rating'][i],pages=data['pages'][i],title=data['title'][i],get=data['GET'][i],cloudflare=str(data['Cloudflare'][i]),ipes=data['IPFS.io'][i],infura=data['Infura'][i])
            instance.save()
        except Exception as e:

            print(e)
        else:
            print("added")
    return HttpResponse("done")
                
@permission_classes((IsAuthenticated,))
class UpdateProfileView(views.APIView):

    # token_param_config = openapi.Parameter(
        # 'token', in_=openapi.IN_QUERY, description='Description', type=openapi.TYPE_STRING)

    # @swagger_auto_schema(manual_parameters=[token_param_config])
    def post(self, request):
        #first_name,last_name,username,coutnry_code,phone_no

       
        user=CustomUser.objects.filter(email=request.data['user']).first()

        
        # user = token
        try:
            if 'name' in request.data.keys():
                user.name = request.data['name']
                print("1")
            if 'username' in request.data.keys():
                user.username = request.data['username']
                print("2")
            if 'intrest' in request.data.keys():
                user.intrest = request.data['intrest']
                print("3")
            if 'dob' in request.data.keys():
                user.dob = request.data['dob']
                print("4")
            user.save()
            return Response({'success': 'Details updated successfully'}, status=status.HTTP_200_OK)
        except Exception as e: 
            return Response({'error': e}, status=status.HTTP_400_BAD_REQUEST)
    
@permission_classes((IsAuthenticated,))
class SerachAPIView(generics.ListCreateAPIView):
    search_fields = ['Author', 'description', 'genre','title']
    filter_backends = (filters.SearchFilter,)
    queryset = Book.objects.all()
    serializer_class = BookSerializer

@permission_classes((IsAuthenticated,))
class exploreAPIView(generics.ListAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer





# Create your views here.
