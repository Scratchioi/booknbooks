# Generated by Django 3.2.8 on 2021-11-22 15:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('first', '0005_auto_20211116_2007'),
    ]

    operations = [
        migrations.AddField(
            model_name='user_interaction',
            name='read_list',
            field=models.BooleanField(default=False),
        ),
    ]