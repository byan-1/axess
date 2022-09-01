from django.shortcuts import render
from django.views.generic import View

# Create your views here.
# class based view for home page
class HomeView(View):
    def get(self, request):
        return render(request, "home/home.html")
