from django.views.generic import TemplateView

from core.constants import BRAND_NAME


class IndexView(TemplateView):
    """Landing page."""
    template_name = 'base/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['brand_name'] = BRAND_NAME
        return context
