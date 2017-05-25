@extends('layouts.default')

@section('title', 'Brands')

@section('breadcrumb-content')
	<li class="active">{{ trans('cards.index') }}</li>
@endsection

@section('content')

	@include('fragments.cards.list', ['cards' => $cards])

@endsection
