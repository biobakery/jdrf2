"""
URLs associated with JDRF pages application.
"""

from django.conf.urls import url

from . import views


urls = [
    url(r'^$', views.protocols, name='protocols')
]
