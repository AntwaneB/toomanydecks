@extends('layouts.admin')

@section('title', $store->name)

@section('content')

<dl>
	<dt>{{ trans('stores.name') }}</dt>
	<dd>{{ $store->name }}</dd>

	<dt>{{ trans('stores.description') }}</dt>
	<dd>{!! nl2br(e($store->description)) !!}</dd>

	<dt>{{ trans('stores.website') }}</dt>
	<dd>
		<a href="{{ $store->website }}" target="_blank">
			{{ $store->website }}
		</a>
	</dd>
</dl>

@endsection