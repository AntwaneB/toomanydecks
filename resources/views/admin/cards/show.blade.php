@extends('layouts.admin')

@section('title', $card->name . ' - ' . $card->brand->name)

@section('content')

<div class="row standard-margin-bottom">
	<div class="col-md-12">
		<a href="{{ route('cards.show', $card) }}" class="btn btn-primary">
			{{ trans('admin.see_store_page') }} <span class="glyphicon glyphicon-arrow-right"></span>
		</a>
	</div>
</div>

<dl>
    <dt>{{ trans('cards.name') }}</dt>
    <dd>{{ $card->name }}</dd>

    <dt>{{ trans('cards.brand') }}</dt>
    <dd>
        <a href="{{ route('admin.brands.show', $card->brand->id) }}">{{ $card->brand->name }}</a>
    </dd>

    <dt>{{ trans('cards.description') }}</dt>
    <dd>{!! nl2br(e($card->description)) !!}</dd>
</dl>

<hr />

<h3>{{ trans('cards.existing_variations') }}</h3>

@include('fragments.forms.errors', ['errors' => $errors])

@include('admin.cards.fragments.variations', ['card' => $card])

@endsection
