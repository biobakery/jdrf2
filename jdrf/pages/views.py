# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render

import filer


def protocols(request):
    """Retrieves all protocols documents uploaded to the JDRF-MBIC using the
    django-filer plugin and renders them to a page for download.
    """
    protocol_root_folder = filer.Folder.filter(name='Protocols')

    # TODO: Need to not make the assumption this folder exists already.
    protocol_root_folder = protocol_root_folder[0]
    protocol_folders = protocol_root_folder.children.all()

    return render(request, 'protocols.html', {protocols: protocol_folders})
