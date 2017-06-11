@extends('layouts.admin')

@section('title', trans('stores.index'))

@section('content')

	<div class="row">
		<div class="col-md-9">
		</div>
		<div class="col-md-3 text-right">
			<a href="{{ route('admin.stores.create') }}" class="btn btn-primary">{{ trans('stores.create') }}</a>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<table class="table table-striped table-hover table-condensed">
				<thead>
				<th>{{ trans('stores.name') }}</th>
				<th>{{ trans('stores.website') }}</th>
				<th>{{ trans('app.edit') }}</th>
				<th>{{ trans('app.delete') }}</th>
				</thead>
				<tbody>
				@foreach ($stores as $store)
					<tr>
						<td>
							<a href="{{ route('admin.stores.show', $store->id) }}">{{ $store->name }}</a>
						</td>
						<td>
							<a href="{{ $store->website }}" target="_blank">{{ $store->website }}</a>
						</td>
						<td>
							<a href="{{ route('admin.stores.edit', $store->id) }}">{{ trans('app.edit') }}</a>
						</td>
						<td>
							<form action="{{ route('admin.stores.destroy', $store->id) }}" method="post">
								{{ method_field('DELETE') }}
								{{ csrf_field() }}
								<input type="submit" value="{{ trans('app.delete') }}" onclick="return confirm('{{ trans('stores.confirm_deletion') }}');" />
							</form>
						</td>
					</tr>
				@endforeach
				</tbody>
			</table>
		</div>
	</div>

@endsection