@extends('layouts.admin')

@section('title', trans('cards.create'))

@section('content')

<form action="{{ route('admin.cards.store') }}" method="post">
    {{ csrf_field() }}

    @include('fragments.forms.errors', ['errors' => $errors])

    <div class="form-group">
        <label for="brand">{{ trans('brands.index') }}</label>
        <select id="brand" name="brand" class="form-control">
            @foreach ($brands as $brand)
                <option value="{{ $brand->id }}">{{ $brand->name }}</option>
            @endforeach
        </select>
    </div>
    <div class="form-group">
        <label for="name">{{ trans('cards.name') }}</label>
        <input type="text" name="name" id="name" class="form-control" placeholder="{{ trans('cards.name') }}" required="required" />
    </div>
    <div class="form-group">
        <label for="description">{{ trans('cards.description') }}</label>
        <textarea name="description" id="description" class="form-control" rows="5" placeholder="{{ trans('cards.description') }}"></textarea>
    </div>

    {{--
    <div class="panel panel-default" v-on:click="addVariation">
        <div class="panel-heading">
            <span class="glyphicon glyphicon-plus"></span>
            {{ trans('variations.add_new') }}
        </div>
        <div class="panel-body hidden">
            <div class="form-group">
                <label for="variation-0-name">{{ trans('variations.name') }}</label>
                <input type="text" name="variations[0][name]" id="variation-0-name" class="form-control" placeholder="{{ trans('variations.name') }}" required="required" />
            </div>
            <div class="form-group">
                <label for="variation-0-description">{{ trans('variations.description') }}</label>
                <textarea name="variations[0][description]" id="variation-0-description" class="form-control" rows="3" placeholder="{{ trans('variations.description') }}"></textarea>
            </div>
        </div>
    </div>
    --}}

    <div class="form-group">
        <input type="submit" value="{{ trans('cards.create') }}" class="btn btn-primary" />
        <input type="reset" value="{{ trans('app.reset') }}" class="btn btn-default" />
    </div>

</form>

@endsection