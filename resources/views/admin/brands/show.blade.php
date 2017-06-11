@extends('layouts.admin')

@section('title', $brand->name)

@section('content')

<dl>
	<dt>{{ trans('brands.name') }}</dt>
	<dd>{{ $brand->name }}</dd>

	<dt>{{ trans('brands.description') }}</dt>
	<dd>{!! nl2br(e($brand->description)) !!}</dd>

	<dt>{{ trans('brands.website') }}</dt>
	<dd>
		<a href="{{ $brand->website }}" target="_blank">
			{{ $brand->website }}
		</a>
	</dd>

	<dt>{{ trans('brands.splash_image') }}</dt>
	<dd>
		<img src="/storage/brands/{{ $brand->slug }}.png" alt="" />
	</dd>
</dl>

@endsection