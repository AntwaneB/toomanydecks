<nav class="navbar top">
    <div class="container">
        <div class="navbar-header">
            <a href="{{ route('app.index') }}" class="navbar-brand">TooManyDecks</a>
        </div>

        <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="{{ route('admin.index') }}" @if (Route::currentRouteName() == 'admin.index') class="active" @endif>
                    {{ trans('admin.index') }}
                </a>
            </li>
            <li>
                <a href="{{ route('admin.brands.index') }}" @if (preg_match('#^admin\.brands\..+#', Route::currentRouteName())) class="active" @endif>
                    {{ trans('brands.index') }}
                </a>
            </li>
            <li>
                <a href="{{ route('admin.cards.index') }}" @if (preg_match('#^admin\.cards\..+#', Route::currentRouteName())) class="active" @endif>
                    {{ trans('cards.index') }}
                </a>
            </li>
            <li>
                <a href="{{ route('admin.stores.index') }}" @if (preg_match('#^admin\.stores\..+#', Route::currentRouteName())) class="active" @endif>
                    {{ trans('stores.index') }}
                </a>
            </li>
            <li>
                <a href="{{ route('admin.crawlers.index') }}" @if (preg_match('#^admin\.crawlers\..+#', Route::currentRouteName())) class="active" @endif>
                    {{ trans('crawlers.index') }}
                </a>
            </li>
        </ul>
    </div>
</nav>
<nav class="navbar bottom">
    <div class="container">
        <ol class="breadcrumb">
            @if (Route::currentRouteName() != 'admin.index')
                <li><a href="{{ route('admin.index') }}">{{ trans('admin.index') }}</a></li>
            @else
                <li class="active">{{ trans('admin.index') }}</li>
            @endif

            @yield('breadcrumb-content')
        </ol>
    </div>
</nav>