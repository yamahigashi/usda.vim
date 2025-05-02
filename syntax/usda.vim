" Vim syntax file
" Language:         OpenUSD ASCII (.usda)
" Author:           Takayoshi Matsumoto <yamahigashi@gmail.com>
" Last Change:      2025-05-02

if exists('b:current_syntax')
  finish
endif
syn clear

" -------------------------------------------------------------------------
"  Basic syntax primitives
" -------------------------------------------------------------------------
syntax case match
syntax sync fromstart

" -------------------
"  Comments & header
" -------------------
syntax match  usdaComment  /^\s*#.*$/      contains=@Spell
syntax match  usdaVersion  /^\s*#usda\s\+\d\+\.\d\+\s*$/ contained
highlight link usdaComment Comment
highlight link usdaVersion Constant

" -------------------
"  Core Keywords
" -------------------
syn keyword usdaKeyword  def over class rel payload subLayers
syn keyword usdaKeyword  references inherits variants variant variantSet variantSets
syn keyword usdaKeyword  dictionary clips customData
syn keyword usdaKeyword  uniform custom timeSamples
syn keyword usdaKeyword  instanceable active hidden kind defaultPrim upAxis
syn keyword usdaKeyword  startTimeCode endTimeCode
syn keyword usdaKeyword  prepend append add delete reorder

highlight link usdaKeyword Keyword

" -------------------
"  Shade / I/O helpers
" -------------------
syn keyword usdaShadeKw  inputs outputs connect
highlight link usdaShadeKw Function

" -------------------
"  Constants & booleans
" -------------------
syn keyword usdaConst  true false none
highlight link usdaConst Boolean

" -------------------
"  Numeric literals
" -------------------
syntax match  usdaNumber  /\v[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?/
highlight link usdaNumber Number

" -------------------
"  Strings & Asset paths
" -------------------
syntax region usdaString      start=+"+ skip=+\\\|\\"+  end=+"+
syntax region usdaString      start=+'+ skip=+\\\|\\'+  end=+'+
syntax match  usdaAssetPath   /@@@[^@]*@@@/
syntax match  usdaAssetPath   /@[^\r\n@]*@/

highlight link usdaString     String
highlight link usdaAssetPath  String

" -------------------
"  Delimiters
" -------------------
syntax match  usdaArrayOpen   /\[/
syntax match  usdaArrayClose  /\]/
syntax match  usdaDictKey     /:/
syntax match  usdaAssign      /=/
syntax match  usdaScopeOpen   /{/
syntax match  usdaScopeClose  /}/
syntax match  usdaPathOpen    /</
syntax match  usdaPathClose   />/
syntax match  usdaArrayCont   /,/

highlight link usdaArrayOpen  Structure
highlight link usdaArrayClose Structure
highlight link usdaScopeOpen  Structure
highlight link usdaScopeClose Structure
highlight link usdaPathOpen   String
highlight link usdaPathClose  String
highlight link usdaDictKey    Delimiter
highlight link usdaAssign     Delimiter
highlight link usdaArrayCont  Delimiter

" -------------------------------------------------------------------------
"  Value-type tokens (USD 24.08 spec)
"  Arrays are highlighted by a second rule so `color3f[]` also matches.
" -------------------------------------------------------------------------
syn keyword usdaType bool
syn keyword usdaType asset token string
syn keyword usdaType uchar uchar2 uchar3 uchar4
syn keyword usdaType half  half2  half3  half4
syn keyword usdaType int   int2   int3   int4   int64
syn keyword usdaType uint  uint2  uint3  uint4  uint64
syn keyword usdaType float float2 float3 float4
syn keyword usdaType double double2 double3 double4
syn keyword usdaType vector3d vector3f vector3h
syn keyword usdaType normal3d normal3f normal3h
syn keyword usdaType point3d  point3f  point3h
syn keyword usdaType color3d  color3f  color3h
syn keyword usdaType color4d  color4f  color4h
syn keyword usdaType matrix2d matrix3d matrix4d
syn keyword usdaType frame4d
syn keyword usdaType quatd quatf quath
syn match   usdaArrayType /\v<(bool|asset|string|token|uchar\d?|half\d?|int(64)?\d?|uint(64)?\d?|float\d?|double\d?|vector3[dfh]|normal3[dfh]|point3[dfh]|color[34][dfh]|matrix[234]d|frame4d|quat[dfh])\[\]>/
highlight link usdaType      Type
highlight link usdaArrayType Type

" -------------------------------------------------------------------------
"  Folding support for { } scopes
" -------------------------------------------------------------------------
syn region usdaBlock start=/{/ end=/}/ transparent fold containedin=ALL

" -------------------------------------------------------------------------
let b:current_syntax = 'usda'

