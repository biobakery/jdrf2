# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render

import filer


def protocols(request):
    """
    Generates page containing all JDRF-MBIC protocols. Takes any files
    uploaded via the django-filer plugin and renders them to this page.

    Arguments:
        request (django.http.HttpRequest.POST): A dictionary-like object
            containing all given HTTP POST parameters

    Requires:
        None

    Returns:
        django.http.HttpResponse: An HTTP response class with a string as
            content.
    """
    protocol_folders = []
    filer_folders = filer.models.Folder.objects.filter(name='Protocols')

    if filer_folders:
        protocol_root_folder = filer_folders[0]
        protocol_folders = protocol_root_folder.children.all()

    return render(request, 'protocols.html', {'protocols': protocol_folders})
