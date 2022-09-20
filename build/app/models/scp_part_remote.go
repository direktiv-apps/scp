// Code generated by go-swagger; DO NOT EDIT.

package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"context"

	"github.com/direktiv/apps/go/pkg/apps"
	"github.com/go-openapi/errors"
	"github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"
)

// ScpPartRemote scp part remote
//
// swagger:model scpPartRemote
type ScpPartRemote struct {

	// host
	Host string `json:"host,omitempty"`

	// identity
	Identity apps.DirektivFile `json:"identity,omitempty"`

	// port
	Port *int64 `json:"port,omitempty"`

	// user
	User string `json:"user,omitempty"`
}

// Validate validates this scp part remote
func (m *ScpPartRemote) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateIdentity(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *ScpPartRemote) validateIdentity(formats strfmt.Registry) error {
	if swag.IsZero(m.Identity) { // not required
		return nil
	}

	if err := m.Identity.Validate(formats); err != nil {
		if ve, ok := err.(*errors.Validation); ok {
			return ve.ValidateName("identity")
		} else if ce, ok := err.(*errors.CompositeError); ok {
			return ce.ValidateName("identity")
		}
		return err
	}

	return nil
}

// ContextValidate validate this scp part remote based on the context it is used
func (m *ScpPartRemote) ContextValidate(ctx context.Context, formats strfmt.Registry) error {
	var res []error

	if err := m.contextValidateIdentity(ctx, formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *ScpPartRemote) contextValidateIdentity(ctx context.Context, formats strfmt.Registry) error {

	if err := m.Identity.ContextValidate(ctx, formats); err != nil {
		if ve, ok := err.(*errors.Validation); ok {
			return ve.ValidateName("identity")
		} else if ce, ok := err.(*errors.CompositeError); ok {
			return ce.ValidateName("identity")
		}
		return err
	}

	return nil
}

// MarshalBinary interface implementation
func (m *ScpPartRemote) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *ScpPartRemote) UnmarshalBinary(b []byte) error {
	var res ScpPartRemote
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}