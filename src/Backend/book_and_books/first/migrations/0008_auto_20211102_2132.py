# Generated by Django 3.2.8 on 2021-11-02 16:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('first', '0007_alter_book_isbn'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='dob',
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='customuser',
            name='intrest',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='customuser',
            name='name',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='customuser',
            name='username',
            field=models.CharField(blank=True, max_length=100, null=True, unique=True),
        ),
        migrations.DeleteModel(
            name='User_features',
        ),
    ]
