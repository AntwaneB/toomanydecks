@extends('layouts.admin')

@section('title', trans('crawlers.create'))

@section('content')

<form action="{{ route('admin.crawlers.store') }}" method="post">
	{{ csrf_field() }}

	@include('fragments.forms.errors', ['errors' => $errors])

	<div class="form-group">
		<label for="store">{{ trans('crawlers.store') }}</label>
		<select name="store" class="form-control">
		@foreach ($stores as $store)
			<option value="{{ $store->id }}">{{ $store->name }}</option>
		@endforeach
		</select>
	</div>
	<div class="form-group">
		<label for="list_url">{{ trans('crawlers.list_url') }}</label>
		<input type="text" name="list_url" id="list_url" placeholder="{{ trans('crawlers.list_url') }}" class="form-control" required="required" />
	</div>
	<div class="form-group">
		<label for="list_frequency">{{ trans('crawlers.list_frequency') }}</label>
		<input type="text" name="list_frequency" id="list_frequency" value="0 3 * * *" placeholder="{{ trans('crawlers.list_frequency') }}" class="form-control" required="required" />
	</div>
	<div class="form-group">
		<label for="cards_frequency">{{ trans('crawlers.cards_frequency') }}</label>
		<input type="text" name="cards_frequency" id="cards_frequency" value="0 3 * * *" placeholder="{{ trans('crawlers.cards_frequency') }}" class="form-control" required="required" />
	</div>
	<div class="form-group">
		<input type="submit" value="{{ trans('crawlers.create') }}" class="btn btn-primary" />
		<input type="reset" value="{{ trans('app.reset') }}" class="btn btn-default" />
	</div>

</form>

@endsection