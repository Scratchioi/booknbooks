from django.http.response import HttpResponse
from django.shortcuts import render
from .models import Book,CustomUser,user_interaction
import pandas as pd
from rest_framework import serializers
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.decorators import action, permission_classes
from rest_framework import viewsets,status,generics,views,filters
from .serializer import CustomUserSerializer, BookSerializer, user_interaction_serializer
from rest_framework.pagination import PageNumberPagination


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
    def get(self, request):
        user=request.user
        if user:
            serializer=CustomUserSerializer(user)
            return Response(serializer.data,status=status.HTTP_200_OK)
        else:
            return Response({'error': 'token error'}, status=status.HTTP_400_BAD_REQUEST)



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
    
# @permission_classes((IsAuthenticated,))
class SerachAPIView(generics.ListCreateAPIView):
    search_fields = ['title', 'Author', 'genre']
    filter_backends = (filters.SearchFilter,)
    queryset = Book.objects.all()
    serializer_class = BookSerializer

# @permission_classes((IsAuthenticated,))
class exploreAPIView(generics.ListCreateAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer

class genre_based_filter(generics.ListAPIView):
    serializer_class = BookSerializer

    def get_queryset(self):
        """
        This view should return a list of all the purchases
        for the currently authenticated user.
        """
        genre = self.request.data.get('genre')
        return Book.objects.filter(genre__contains=genre)


class user_interactions(views.APIView):
    def get(self,request):
        try:
            user=user_interaction.objects.filter(user=request.user)
            dic={'user':request.user.email}
            j=1
            for i in user:
                if i.read_list:
                    serializer=BookSerializer(i.book)
                    dic[j]=serializer.data
                    dic[j]['read']=i.read
                    dic[j]['completed']=i.completed
                    dic[j]['page_num']=i.page_num
                    dic[j]['read_list']=i.read_list
                    j+=1
            return Response(dic,status=status.HTTP_200_OK)
        except Exception as e:
            Response({'error':f'{e}'},status=status.HTTP_400_BAD_REQUEST)






    def post(self,request):
        try:
            user=request.data['user']
            book=request.data['isbn']

            user=CustomUser.objects.filter(email=user).first()
            book=Book.objects.filter(isbn=book).first()
            if user is None:
                return Response({"error":"user does't exist"},status=status.HTTP_400_BAD_REQUEST)
            if book is None:
                return Response({"error":"book does't exist"},status=status.HTTP_400_BAD_REQUEST)
                
            print('working')
            user_i,value=user_interaction.objects.get_or_create(user=user,book=book)
            
            print(user,book,user_i)
            print(user_i.read)


            if 'read' in request.data.keys():
                user_i.read=request.data['read']
            if 'complete' in request.data.keys():
                user_i.completed=request.data['complete']
            if 'page_num' in request.data.keys():
                user_i.page_num=request.data['page_num']
            if 'read_list' in request.data.keys():
                user_i.read_list=request.data['read_list']
            user_i.save()
            return Response({'success': 'Details updated successfully'}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'e':f'{e}'},status=status.HTTP_400_BAD_REQUEST)





    







# Create your views here.
