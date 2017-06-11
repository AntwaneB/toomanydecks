@extends('layouts.admin')

@section('title', trans('brands.create'))

@section('content')

<form action="{{ route('admin.brands.store') }}" method="post" enctype="multipart/form-data">
    {{ csrf_field() }}

	@include('fragments.forms.errors', ['errors' => $errors])

    <div class="form-group">
        <label for="name">{{ trans('brands.name') }}</label>
        <input type="text" name="name" id="name" class="form-control" placeholder="{{ trans('brands.name') }}" required="required" />
    </div>
    <div class="form-group">
        <label for="description">{{ trans('brands.description') }}</label>
        <textarea name="description" id="description" class="form-control" rows="5" placeholder="{{ trans('brands.description') }}"></textarea>
    </div>
    <div class="form-group">
        <label for="website">{{ trans('brands.website') }}</label>
	    <input type="text" name="website" id="website" class="form-control" placeholder="{{ trans('brands.website') }}" required="required" />
    </div>
	<div class="form-group">
        <label for="splash_image">{{ trans('brands.splash_image') }}</label>
	    <input type="file" name="splash_image" id="splash_image" />
    </div>

    <div class="form-group">
        <input type="submit" value="{{ trans('brands.create') }}" class="btn btn-primary" />
        <input type="reset" value="{{ trans('app.reset') }}" class="btn btn-default" />
    </div>

</form>

@endsection