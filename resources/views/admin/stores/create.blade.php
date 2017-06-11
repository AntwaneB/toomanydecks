@extends('layouts.admin')

@section('title', trans('stores.create'))

@section('content')

<form action="{{ route('admin.stores.store') }}" method="post">
    {{ csrf_field() }}

	@include('fragments.forms.errors', ['errors' => $errors])

    <div class="form-group">
        <label for="name">{{ trans('stores.name') }}</label>
        <input type="text" name="name" id="name" class="form-control" placeholder="{{ trans('stores.name') }}" required="required" />
    </div>
    <div class="form-group">
        <label for="description">{{ trans('stores.description') }}</label>
        <textarea name="description" id="description" class="form-control" rows="5" placeholder="{{ trans('stores.description') }}"></textarea>
    </div>
    <div class="form-group">
        <label for="website">{{ trans('stores.website') }}</label>
	    <input type="text" name="website" id="website" class="form-control" placeholder="{{ trans('stores.website') }}" required="required" />
    </div>

    <div class="form-group">
        <input type="submit" value="{{ trans('stores.create') }}" class="btn btn-primary" />
        <input type="reset" value="{{ trans('app.reset') }}" class="btn btn-default" />
    </div>

</form>

@endsection