@extends('layouts.admin')

@section('title', trans('cards.index'))

@section('content')

<div class="row">
    <div class="col-md-9">
        {{ $cards->links() }}
    </div>
    <div class="col-md-3 text-right">
        <a href="{{ route('admin.cards.create') }}" class="btn btn-primary">{{ trans('cards.create') }}</a>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <table class="table table-striped table-hover table-condensed">
            <thead>
                <th>{{ trans('cards.name') }}</th>
                <th>{{ trans('cards.brand') }}</th>
                <th>{{ trans('cards.variations_count') }}</th>
                <th>{{ trans('app.edit') }}</th>
                <th>{{ trans('app.delete') }}</th>
            </thead>
            <tbody>
                @foreach ($cards as $card)
                    <tr>
                        <td>
                            <a href="{{ route('admin.cards.show', $card->id) }}">{{ $card->name }}</a>
                        </td>
                        <td>{{ $card->brand->name }}</td>
                        <td>{{ $card->variationsCount }}</td>
                        <td>
                            <a href="{{ route('admin.cards.edit', $card->id) }}">{{ trans('app.edit') }}</a>
                        </td>
                        <td>
                            <form action="{{ route('admin.cards.destroy', $card->id) }}" method="post">
                                {{ method_field('DELETE') }}
                                {{ csrf_field() }}
                                <input type="submit" value="{{ trans('app.delete') }}" onclick="return confirm('{{ trans('cards.confirm_deletion') }}');" />
                            </form>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <div class="col-md-9">
        {{ $cards->links() }}
    </div>
    <div class="col-md-3 text-right">
        <a href="{{ route('admin.cards.create') }}" class="btn btn-primary">{{ trans('cards.create') }}</a>
    </div>
</div>

@endsection