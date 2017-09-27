"""
URLs associated with JDRF pages application.
"""

from django.conf.urls import url

from . import views


urlpatterns = [
    url(r'^$', views.protocols, name='protocols')
]
