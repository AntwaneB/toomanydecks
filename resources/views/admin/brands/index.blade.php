@extends('layouts.admin')

@section('title', trans('cards.index'))

@section('content')

<div class="row">
	<div class="col-md-9">
	</div>
	<div class="col-md-3 text-right">
		<a href="{{ route('admin.brands.create') }}" class="btn btn-primary">{{ trans('brands.create') }}</a>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<table class="table table-striped table-hover table-condensed">
			<thead>
			<th>{{ trans('brands.name') }}</th>
			<th>{{ trans('brands.website') }}</th>
			<th>{{ trans('app.edit') }}</th>
			<th>{{ trans('app.delete') }}</th>
			</thead>
			<tbody>
			@foreach ($brands as $brand)
				<tr>
					<td>
						<a href="{{ route('admin.brands.show', $brand->id) }}">{{ $brand->name }}</a>
					</td>
					<td>
						<a href="{{ $brand->website }}" target="_blank">{{ $brand->website }}</a>
					</td>
					<td>
						<a href="{{ route('admin.brands.edit', $brand->id) }}">{{ trans('app.edit') }}</a>
					</td>
					<td>
						<form action="{{ route('admin.brands.destroy', $brand->id) }}" method="post">
							{{ method_field('DELETE') }}
							{{ csrf_field() }}
							<input type="submit" value="{{ trans('app.delete') }}" onclick="return confirm('{{ trans('brands.confirm_deletion') }}');" />
						</form>
					</td>
				</tr>
			@endforeach
			</tbody>
		</table>
	</div>
</div>

@endsection